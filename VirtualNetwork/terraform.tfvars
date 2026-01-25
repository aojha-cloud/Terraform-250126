subscription_id        = "52db85a1-799d-4e94-be9f-60f0c3d0c646"
vnet_name              = "ojha_vnet"
address_space          = ["10.0.0.0/16"]
dns_servers            = ["10.0.0.4", "10.0.0.5"]
address_prefixes       = ["10.0.1.0/24"]
encryption             = "MicrosoftManagedKeys"
enable_ddos_protection = false
tags = {
  created_by  = "Pooja_ojha"
  environment = "dev"
}
sbnet1name = "Sbnet1"