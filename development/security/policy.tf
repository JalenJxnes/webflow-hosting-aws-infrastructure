/* Create Elastic Beanstalk policy statement */
data "aws_iam_policy_document" "beanstalk_access" {
    statement {
        actions = ["s3:GetObject", "s3:GetObjectVersion"]
        effect = "Allow"
        resources = ["${aws_s3_bucket.webflow-bucket.arn}/*"]
    }
}

/* Create Elastic Beanstalk policy object */
resource "aws_iam_policy" "elastic_beanstalk_policy" {
    name = "${locals.policy_name}"
    description = "Elastic Beanstalk access policy to S3 bucket"
    policy = data.aws_iam_policy_document.beanstalk_access.json
}

resource "aws_iam_role" "beanstalk_ec2" {
    name = "${variables.beanstalk_role_name}-ec2-role"

    assume_role_policy = jsonenconde ({
        Version: "2012-10-17"
        Statement = [
            {
                Action: "sts:AssumeRole"
                Effect: "Allow"
                Principle: {
                    Service: "ec2.amazonaws.com"
                }
            }
        ]
    })
}
