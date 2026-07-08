module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  azs                   = var.azs
  environment           = var.environment
}

module "web_server" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  environment   = var.environment
  key_name      = var.key_name
}
