resource "aws_iam_role" "aws_access_rwa_jta" {
    name = "${var.prefix}_role"
    assume_role_policy =  jsonencode({
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
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]
}