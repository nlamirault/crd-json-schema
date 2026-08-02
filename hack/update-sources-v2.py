import yaml

with open("sources.yaml", "r") as f:
    data = yaml.safe_load(f)

for source in data["sources"]:
    sid = source["id"]
    
    # Rename categories
    if source.get("category") == "Core Kubernetes":
        source["category"] = "Kubernetes"

    # Move Karpenter to Kubernetes
    if sid.startswith("karpenter"):
        source["category"] = "Kubernetes"

    # Ensure project for ack
    if sid.startswith("ack-"):
        source["project"] = "ack"
    
    # Ensure project for karpenter
    if sid.startswith("karpenter"):
        source["project"] = "karpenter"
    
    # Ensure project for gateway-api
    if sid.startswith("gateway-api"):
        source["project"] = "gateway-api"

with open("sources.yaml", "w") as f:
    yaml.dump(data, f, default_flow_style=False, sort_keys=False)
