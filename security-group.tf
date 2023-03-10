module "sg_rds" {
  source  = "../security-group"
  name    = "${var.name}-rds"
  vpc_id  = var.vpc_id
  egress  = var.egress
  ingress = var.ingress
  providers = {
    aws = aws
  }
}