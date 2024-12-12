resource "aws_iam_role" "criar_role_rwa_jta" {
    name = "${var.prefix}-role"
    assume_role_policy = jsonencode({
        version = "2012-10-17"
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
}

resource "aws_iam_role_policy_attachment" "anexar_politica_rwa_jta" {
    role = aws_iam_role.criar_role_rwa_jta.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}