locals {
  nsg_rules_csv_path = "./nsg_rules_csv"
  #step1: Load all CSVs in the directory and decode each

  raw_rows = flatten(
    [
        for f in fileset(local.nsg_rules_csv_path, "*.csv") :[
            for row in csvdecode(file("${local.nsg_rules_csv_path}/${f}")) :row
        ]
    ]
  )
  parsed_rules = [
    for row in local.raw_rows : { 
        nsg_name = replace(row["nsg_name"], "/\\s+/", "") # Remove extra spaces
        nsg_resourceGroup = replace(row["nsg_resourceGroup"], "/\\s+/", "")
        location = replace(row["location"], "/\\s+/", "") # Remove extra spaces
        rules = {
            priority = length(replace(row["priority"], "/\\s+/", "")) > 0 ? tonumber(replace(row["priority"], "/\\s+/", "")) : null
            source_port_range = length(regexall("[^,+]+", row["source_port"])) > 1 ? null : replace(row["source_port"], "/\\s+/", "")
            source_port_ranges = length(regexall("[^,+]+", row["source_port"])) > 1 ? [for p in regexall("[^,+]+", row["source_port"]) : trimspace(replace((p), "/\\s+/", ""))] : null
            destination_port_range = length(regexall("[^,+]+", row["destination_port"])) > 1 ? null : replace(row["destination_port"], "/\\s+/", "")
            destination_port_ranges = length(regexall("[^,+]+", row["destination_port"])) > 1 ? [for p in regexall("[^,+]+", row["destination_port"]) : trimspace(replace((p), "/\\s+/", ""))] : null
            source_address_prefix = length(regexall("[^,+]+", row["source"])) > 1 ? null : replace(row["source"], "/\\s+/", "")
            source_address_prefixes = length(regexall("[^,+]+", row["source"])) > 1 ? [for p in regexall("[^,+]+", row["source"]) : trimspace(replace((p), "/\\s+/", ""))] : null
            destination_address_prefix = length(regexall("[^,+]+", row["destination"])) > 1 ? null : replace(row["destination"], "/\\s+/", "")
            destination_address_prefixes = length(regexall("[^,+]+", row["destination"])) > 1 ? [for p in regexall("[^,+]+", row["destination"]) : trimspace(replace((p), "/\\s+/", ""))] : null
            protocol = length("${upper(substr(row.protocol, 0, 1))}${lower(substr(row.protocol, 1, length(row.protocol)-1))}") > 0 ? "${upper(substr(row.protocol, 0, 1))}${lower(substr(row.protocol, 1, length(row.protocol)-1))}" : null
            access = length("${upper(substr(row.access, 0, 1))}${lower(substr(row.access, 1, length(row.access) - 1))}") > 0 ? "${upper(substr(row.access, 0, 1))}${lower(substr(row.access, 1, length(row.access)-1))}" : null
            direction = length("${upper(substr(row.direction, 0, 1))}${lower(substr(row.direction, 1, length(row.direction) - 1))}") > 0 ? "${upper(substr(row.direction, 0, 1))}${lower(substr(row.direction, 1, length(row.direction)-1))}" : null
            name = length(replace(row["rule_name"], "/\\s+/", "")) > 0 ? replace(row.rule_name, "/\\s+/", "") : null

        }
    }
  
  ]
  cleaned_rules = [
    for r in local.parsed_rules : merge(
        r,
        {
            rules = {
                for k, v in r.rules : k => v
                if v != null && v != "" #remove nulls; also removes empty strings which are not valid for NSG rules

            }
        }
    )
  ]

  nsg-config = {
    for nsg-key in distinct ([ for r in local.cleaned_rules : r.nsg_name]) :
    nsg-key => {
        nsg_name = nsg-key
        location = [
            for r in local.cleaned_rules : r.location
            if r.nsg_name == nsg-key][0] #take location from the first rule for this NSG
        nsg_resourceGroup = [
                for r in local.cleaned_rules : r.nsg_resourceGroup
                if r.nsg_name == nsg-key][0] #take resource group from the first rule for this NSG
        security_rules = [
            for r in local.cleaned_rules : 
            r.rules if r.nsg_name == nsg-key && length(r.rules) > 0
        ]
    }
  }
}
output "print" {
    value = local.nsg-config
  
}