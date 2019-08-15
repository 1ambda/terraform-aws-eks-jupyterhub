data "template_file" "bastion_userdata_install_cloudwatch_metric" {
  template = file("${path.root}/template/template.cloudwatch-metric-ec2.sh")

  vars = {
    user                       = "ec2-user"
    installer                  = "yum"
    agent_version              = "1.2.2"
  }
}

data "template_file" "bastion_user_data_mount_efs_common_shared" {
  template = file("${path.root}/template/template.ec2-mount-efs.sh")

  vars = {
    user = "ec2-user"
    nfs_installer_command       = ""
    mount_local_path            = "/mnt/efs-jupyter-shared"
    mount_remote_path           = "/"
    mount_dns                   = var.dns_efs_jupyter_shared
  }
}

data "template_cloudinit_config" "bastion_user_data" {
  gzip          = false
  base64_encode = true

  # install patches for Amazon Linux
  part {
    content_type = "text/x-shellscript"

    content = <<EOF
#!/bin/bash

yum update -y

EOF
  }

  # https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/amazon-linux-install.html
  # install correto8
  part {
    content_type = "text/x-shellscript"

    content = <<EOF
#!/bin/bash

amazon-linux-extras enable corretto8
yum install -y java-1.8.0-amazon-corretto-devel

EOF
  }

  # install agent for cloudwatch custom metric
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.bastion_userdata_install_cloudwatch_metric.rendered
  }

  # mount efs-common-shared
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.bastion_user_data_mount_efs_common_shared.rendered
  }
}
