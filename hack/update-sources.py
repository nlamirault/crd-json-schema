import yaml

with open("sources.yaml", "r") as f:
    data = yaml.safe_load(f)

for source in data["sources"]:
    sid = source["id"]
    if sid.startswith("ack-"):
        source["project"] = "ack"
    elif sid.startswith("karpenter-"):
        source["project"] = "karpenter"
    elif sid.startswith("gateway-api"):
        source["project"] = "gateway-api"

with open("sources.yaml", "w") as f:
    yaml.dump(data, f, default_flow_style=False, sort_keys=False)
