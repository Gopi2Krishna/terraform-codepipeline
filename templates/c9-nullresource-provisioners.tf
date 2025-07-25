resource "null_resource" "name" {
    depends_on = [ module.ec2-bastion]

    connection {
        type = "ssh"
        host = aws_eip.bastion_eip.public_ip
        user = "ec2-user"
        password = ""
        private_key = file("private-key/terraform-key.pem")
    }

    provisioner "file" {
        source = "private-key/terraform-key.pem"
        destination = "/tmp/terraform-key.pem"
    }
    
    provisioner "remote-exec" {
        inline = [ "sudo chmod 400 /tmp/terraform-key.pem"]
    }

    provisioner "local-exec" {
      working_dir = "local-exec-files/"
      command = "echo VPC created on `date` and ID is: ${module.vpc.vpc_id} >> createdDate.txt"
    }


}