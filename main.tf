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

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
 
  tags = {
    application_acronym = "TTO"
  }
}
 
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
