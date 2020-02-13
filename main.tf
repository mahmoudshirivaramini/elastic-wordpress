# Deploy Networking Resources
module "networking" {
  source                = "./networking"
  vpc_cidr              = var.vpc_cidr
  DMZPublic_cidrs       = var.DMZPublic_cidrs
  AppLayerPrivate_cidrs = var.AppLayerPrivate_cidrs
  DBLayerPrivate_cidrs  = var.DBLayerPrivate_cidrs
  accessip              = var.accessip
}