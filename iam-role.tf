resource "aws_iam_role" "aws_access_rwa_jta" {
    name = "${var.prefix}_role"
    assume_role_policy =  jsondecode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
    managed_policy_arns = ["arn:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]
}