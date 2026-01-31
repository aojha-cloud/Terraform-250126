subscription_id     = "52db85a1-799d-4e94-be9f-60f0c3d0c646"
nsg_name            = "pooja-nsg"
location            = "East US"
resource_group_name = "ojha_rg"
tags = {
  Environment = "Production"
  Project     = "TerraformModule"
}
security_rules = [
  {
    name                                       = "AllowSSH"
    description                                = "Allow SSH inbound traffic"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    source_port_ranges                         = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
]
