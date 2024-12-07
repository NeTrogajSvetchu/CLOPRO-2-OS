module "vpc"  {
  source     =  "./vpc"
  folder_id  = var.folder_id
  token      = var.token
  cloud_id   = var.cloud_id
}

module "backet-1"  {
  source = "./backet-1"
  folder_id  = var.folder_id
  token      = var.token
  cloud_id   = var.cloud_id
}

module "group_vm" {
  bucket = module.backet-1.bucked
  source = "./group_vm"
  folder_id  = var.folder_id
  token      = var.token
  cloud_id   = var.cloud_id
  id = module.vpc.id
  subnet_ids = module.vpc.subnet_ids
 
}

module "load_balancer" {
  
  source          = "./load_balancer"
  target_group_id = module.group_vm.target_group_id
  folder_id       = var.folder_id
  token           = var.token
  cloud_id        = var.cloud_id
}

module "application_balancer" {
  source     = "./application_balancer"
  folder_id  = var.folder_id
  token      = var.token
  cloud_id   = var.cloud_id
  id         = module.vpc.id
  subnet_ids = module.vpc.subnet_ids
  group_wm1  = module.group_vm.group_wm1
  group_wm2  = module.group_vm.group_wm2
  group_wm3  = module.group_vm.group_wm3
}