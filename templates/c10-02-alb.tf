module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  depends_on                 = [module.vpc]
  name                       = "${local.name}-alb"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  load_balancer_type         = "application"
  security_groups            = [module.loadbalancer_sg.security_group_id]
  tags                       = local.tags
  enable_deletion_protection = false
  listeners = {
    http-listner = {
      port     = 80
      protocol = "HTTP"
      # Fixed Response for Root Context       
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      } # End of Fixed Response

      rules = {
        # Rule-1: myapp1-rule
        app1-rule = {
          priority = 10
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "tg1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app1*"]
            }
          }]
        } # End of myapp1-rule

        # Rule-2: app2-rule
        app2-rule = {
          priority = 30
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "tg2"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/*"]
            }
          }]
        } # End of myapp3-rule Block
      }   #end of rules
    }     #end of http listner
  }       #end of listners

  target_groups = {
    tg1 = {
      #This will stop alb from attaching the ec2 instances to tg
      ## we can only associate a ASG or single ec2 using this tg, 
      ###to overcome this we use aws_lb_target_group_attachment resource from aws.
      create_attachment                 = false
      name_prefix                       = "${local.name}-tg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = local.tags
    } # end of tg1
  }   # end of tgs
}

resource "aws_lb_target_group_attachment" "tg1" {
  for_each         = { for instance, instance_details in module.ec2-private : instance => instance_details }
  target_id        = each.value.id
  target_group_arn = module.alb.target_groups["tg1"].arn
  port             = 80
}

