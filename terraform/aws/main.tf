module "network" {
  source = "./modules/network"

  project        = var.project
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "lb" {
  source = "./modules/lb"

  project    = var.project
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.subnet_ids

  target_count = var.instance_count
  target_ids   = module.compute.instance_ids
}

module "compute" {
  source = "./modules/compute"

  project           = var.project
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.subnet_ids
  instance_count    = var.instance_count
  instance_type     = var.instance_type
  key_name          = var.key_name
  lb_sg_id          = module.lb.security_group_id
  ssh_allowed_cidrs = var.ssh_allowed_cidrs
}
