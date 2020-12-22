locals {

  # account_id              = data.aws_caller_identity.current.account_id
  app_name                = "abc"
  application_id          = "APID001"
  cost_centre             = "CC001"
  iam_name_prefix         = "abc"
  service_name            = "xyz"
  disable_api_termination = "false"
  # alb_access_logs_bucket  = "${local.account_id}-alb-log-bucket"
  proxy_host              = ""

  account_configs = {
    develop = {
      asg_max_size         = "2"
      asg_min_size         = "1"
      asg_power_mgt_code   = "BH" //Bussinus Hours
      certificate_arn      = ""
      instance_type        = "t2.micro"
      record_set_name      = "cmcloudlab1817.info."
      ondemand_percentage  = "0"
      spot_price           = "0.50"
      asg_desired_capacity = "2"
    }

    sit = {
      asg_max_size         = "2"
      asg_min_size         = "1"
      asg_power_mgt_code   = "BH" //Bussinus Hours
      certificate_arn      = ""
      instance_type        = "t2.micro"
      record_set_name      = "cmcloudlab1817.info."
      ondemand_percentage  = "0"
      spot_price           = "0.50"
      asg_desired_capacity = "2"
    }

    prod = {
      asg_max_size         = "2"
      asg_min_size         = "1"
      asg_power_mgt_code   = "24X7"
      certificate_arn      = ""
      instance_type        = "t3.medium"
      record_set_name      = "cmcloudlab1817.info."
      ondemand_percentage  = "0"
      spot_price           = "0.50"
      asg_desired_capacity = "2"
    }
  }

  tags = {
    ApplicationID = local.application_id
    CostCentre    = local.cost_centre
    ServiceName   = local.service_name
    Environment   = var.environment
  }

  account_config = local.account_configs[var.environment]
}
