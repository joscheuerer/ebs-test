provider "aws" {
 region = "eu-west-1" # Change as needed
 }
resource "aws_instance" "example" {
 ami          = "ami-099a8245f5daa82bf" # Amazon Linux 2 AMI ID for eu-west-1
 instance_type = "m5.4xlarge"
 availability_zone = "eu-west-1a" # Make sure volumes are in the same AZ
 root_block_device {
   volume_size          = 8
   delete_on_termination = false
   tags = {
   Name = "EC2-with-3-EBS"
   application_acronym = "TTO"
 }
 }
 ebs_block_device {
   device_name          = "/dev/sdf"
   volume_size          = 10
   tags = {
   Name = "EC2-with-3-EBS"
 }
 }
 ebs_block_device {
   device_name          = "/dev/sdg"
   volume_size          = 10
   delete_on_termination = true
   tags = {
   Name = "EC2-with-3-EBS"
   application_acronym = "TTO"
 }
 }
 ebs_block_device {
   device_name          = "/dev/sdh"
   volume_size          = 10
   tags = {
   Name = "EC2-with-3-EBS"
   application_acronym = "TTO"
 }
 }
 tags = {
   Name = "EC2-with-3-EBS"
   application_acronym = "TTO"
 }
 }
