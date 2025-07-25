resource "aws_launch_template" "lt-1" {
  name                   = "base-lt-1"
  description            = "basic launch template"
  vpc_security_group_ids = [module.private-sg.security_group_id]
  image_id               = data.aws_ami.amznlnx.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = filebase64("${path.module}/app1-install.sh")
  ebs_optimized          = true
  tags                   = local.tags
  monitoring {
    enabled = true
  }
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      volume_type           = "gp3"
      volume_size           = 8
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      name = "${local.name}-${random_pet.this.id}"

    }
  }
}
