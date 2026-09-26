module "network" {
  source = "./modules/network"
  vpc_cidr_block = var.vpc_cidr_block
  subnet1a_cidr_block = var.subnet1a_cidr_block
  subnet1c_cidr_block = var.subnet1c_cidr_block 
}

module "compute" {
  source = "./modules/compute"
  vpc_id_input = module.network.vpc_id_output
  subnet1a_id_input = module.network.subnet1a_id_output
  subnet1c_id_input = module.network.subnet1c_id_output
}