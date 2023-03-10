# RDS
Below is an examples of calling this module.

## Create RDS instances
```
module "rds" {
  source = "./rds"
  name                            = "my-rds"
  engine                          = "aurora-postgresql"
  engine_version                  = "13.6"
  master_username                 = "admin"
  master_password                 = "admin"
  database_name                   = "api"
  instance_class                  = "db.t3.medium"
  instance_count                  = 1 ## more than one for failover
  backup_retention_period         = 1
  backup_window                   = "02:00-03:00"
  maintenance_window              = "sun:05:00-sun:06:00"
  enabled_cloudwatch_logs_exports = ["postgresql"]

  ## Network
  subnets                         = ["subnet_1", "subnet_2"]
  vpc_id                          = vpc_id
  publicly_accessible = false

  ## monitoring
  enhanced_monitoring_interval = 60

  ## performance insight
  performance_insights_enabled = true

  deletion_protection = true
  skip_final_snapshot = false

  ## Security group rules
  ingress = [
    {
      port        = 5432
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  instance_custom_parameters = [
    # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html
    # Parameters are either static or dynamic.
    # Static: When you change a static parameter and save the DB cluster parameter group, the parameter change takes effect after you manually reboot 
    # Dynamic: When you change a dynamic parameter, by default the parameter change is applied to your DB cluster immediately, without requiring a reboot
    {
      apply_method = "pending-reboot"
      name         = "parameter"
      value        = "value"
    }
  ]
```