// https://aws.amazon.com/amazon-linux-2/release-notes/
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }

  filter {
    name = "name"

    values = [
      // amzn2-ami-hvm-2.0.20181114-x86_64-gp2
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
}

//  https://aws.amazon.com/amazon-linux-ami/
data "aws_ami" "amazon_linux_1" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-*-x86_64-gp2",
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}
