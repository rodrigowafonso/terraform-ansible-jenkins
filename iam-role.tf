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
}

resource "aws_iam_role_policies_exclusive" "associa_role_rwa_jta" {
    role_name = aws_iam_role.aws_access_rwa_jta.name
    policy_names = [aws_iam_role_policy.associa_role_rwa_jta.name]
}