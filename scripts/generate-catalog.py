import os
import json
import re

def generate_catalog(schemas_dir, output_dir):
    catalog = {"groups": {}}
    titles = {}

    for root, dirs, files in os.walk(schemas_dir):
        for file in files:
            if file.endswith(".json"):
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path, schemas_dir)

                # Extract group from directory name
                group = os.path.basename(root)

                # Parse Kind and Version from filename (Kind_Version.json)
                match = re.match(r"(.+)_([vV]\w+)\.json", file)
                if match:
                    raw_kind, version = match.groups()
                    # Try to get the proper Kind from the JSON title if possible
                    kind = raw_kind

                    if group not in catalog["groups"]:
                        catalog["groups"][group] = []

                    try:
                        with open(file_path, 'r') as f:
                            content = f.read()
                            decoder = json.JSONDecoder()
                            data, _ = decoder.raw_decode(content)
                            title = data.get("title", "")
                            if title and "." in title:
                                kind = title.split(".")[-1]

                            catalog["groups"][group].append({
                                "kind": kind,
                                "version": version,
                                "file": rel_path,
                                "slug": f"{group}/{version}/{kind}"
                            })

                            # Store title mapping
                            if title:
                                titles[title] = rel_path
                    except Exception as e:
                        print(f"Error parsing {file_path} for metadata: {e}")

    # Sort groups and resources
    sorted_catalog = {"groups": {}}
    for group in sorted(catalog["groups"].keys()):
        resources = sorted(catalog["groups"][group], key=lambda x: (x["kind"], x["version"]))
        sorted_catalog["groups"][group] = resources

    # Annotate groups with metadata from sources.yaml
    _annotate_from_sources(sorted_catalog, output_dir)

    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)

    with open(os.path.join(output_dir, "catalog.json"), "w") as f:
        json.dump(sorted_catalog, f, indent=2)

    with open(os.path.join(output_dir, "titles.json"), "w") as f:
        json.dump(titles, f, indent=2, sort_keys=True)

    print(f"Catalog generated in {output_dir}")


def _annotate_from_sources(catalog, output_dir):
    """Read sources.yaml and attach category/upstream/cncf_maturity to each group."""
    sources_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "sources.yaml")
    if not os.path.exists(sources_path):
        print(f"Warning: {sources_path} not found — skipping source annotation")
        return

    try:
        import yaml
    except ImportError:
        print("Warning: PyYAML not installed — skipping source annotation (pip install pyyaml)")
        return

    with open(sources_path, "r") as f:
        data = yaml.safe_load(f)

    # Build group → source metadata mapping
    group_meta = {}
    for source in data.get("sources", []):
        meta = {
            "category": source.get("category"),
            "upstream": source.get("upstream"),
            "cncf_maturity": source.get("cncf"),
        }
        for group in source.get("groups", []):
            # Don't overwrite — first declaration wins (important for argoproj.io etc.)
            if group not in group_meta:
                group_meta[group] = meta

    # Annotate catalog entries
    for group, resources in catalog["groups"].items():
        meta = group_meta.get(group, {})
        for resource in resources:
            if meta.get("category"):
                resource["category"] = meta["category"]
            if meta.get("upstream"):
                resource["upstream"] = meta["upstream"]
            if meta.get("cncf_maturity") is not None:
                resource["cncf_maturity"] = meta["cncf_maturity"]

    # Also write a group-level metadata file for convenience
    os.makedirs(output_dir, exist_ok=True)
    group_metadata = {}
    for group in sorted(catalog["groups"].keys()):
        group_metadata[group] = group_meta.get(group, {})

    with open(os.path.join(output_dir, "sources.json"), "w") as f:
        json.dump(group_metadata, f, indent=2)


if __name__ == "__main__":
    generate_catalog("schemas", "public/data")
