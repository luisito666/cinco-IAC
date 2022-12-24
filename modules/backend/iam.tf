resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "${var.stage}-${var.project}-ecsTaskExecutionRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}
resource "aws_iam_role" "ecstaskrole" {
  name = "${var.stage}-${var.project}-ecsTaskRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "",
          "Effect" : "Allow",
          "Principal" : {
                "Service": [
                    "ecs-tasks.amazonaws.com",
                    "s3.amazonaws.com",
                    "ecs.amazonaws.com",
                    "lambda.amazonaws.com",
                    "batch.amazonaws.com"
                ]
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecsTaskRolePolicy" {
  name = "${var.stage}-${var.project}-ecsTaskRolePolicy"
  role = aws_iam_role.ecstaskrole.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
{
    "Statement": [
        {
            "Action": [
                //"s3:PutObject",
                //"s3:PutObjectTagging",
                //"s3:PutObjectVersionTagging", 
                // Permission add by Unoraya //
                "s3:*"
            ],
            "Effect": "Allow",
            //"Resource": "arn:aws:s3:::*",
            "Resource": "*"
            "Sid": "Stmt1532966429082"
        },
        {
            "Action": "lambda:*",
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "Stmt1532967608746"
        },
        {
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets",
                "xray:GetSamplingStatisticSummaries"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ],
            "Sid": "XRayDaemonWriteAccess"
        },
        {
            "Action": [
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets",
                "xray:GetSamplingStatisticSummaries",
                "xray:BatchGetTraces",
                "xray:GetServiceGraph",
                "xray:GetTraceGraph",
                "xray:GetTraceSummaries",
                "xray:GetGroups",
                "xray:GetGroup",
                "xray:GetTimeSeriesServiceStatistics",
                "xray:GetInsightSummaries",
                "xray:GetInsight",
                "xray:GetInsightEvents",
                "xray:GetInsightImpactGraph"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ],
    "Version": "2012-10-17"
 }
  )
}

resource "aws_iam_role_policy" "ecsTaskExecutionPolicy" {
  name = "${var.stage}-${var.project}-ecsTaskExecutionPolicy"
  role = aws_iam_role.ecsTaskExecutionRole.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "autoscaling:SetInstanceProtection",
            "autoscaling:PutScalingPolicy",
            "autoscaling:UpdateAutoScalingGroup",
            "autoscaling:DeletePolicy"
          ],
          "Resource" : "*",
          "Condition" : {
            "Null" : {
              "autoscaling:ResourceTag/AmazonECSManaged" : "false"
            }
          }
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : [
            "cloudwatch:PutMetricAlarm",
            "logs:CreateLogStream",
            "cloudwatch:DeleteAlarms",
            "logs:DescribeLogStreams",
            "ec2:CreateTags",
            "cloudwatch:DescribeAlarms",
            "logs:PutLogEvents"
          ],
          "Resource" : [
            "arn:aws:logs:::log-group:/aws/ecs/:log-stream:",
            "arn:aws:ec2:::network-interface/*",
            "arn:aws:cloudwatch:::alarm:*"
          ]
        },
        {
          "Sid" : "VisualEditor2",
          "Effect" : "Allow",
          "Action" : [
            "autoscaling:Describe*",
            "elasticloadbalancing:RegisterTargets",
            "logs:*",
            "servicediscovery:List*",
            "ecr:ListTagsForResource",
            "route53:UpdateHealthCheck",
            "route53:DeleteHealthCheck",
            "ecr:ListImages",
            "route53:Get*",
            "route53:CreateHealthCheck",
            "ec2:DeleteNetworkInterfacePermission",
            "ec2:CreateNetworkInterfacePermission",
            "route53:List*",
            "elasticloadbalancing:Describe*",
            "ecr:DescribeRepositories",
            "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
            "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetLifecyclePolicy",
            "ecr:GetRegistryPolicy",
            "ec2:DetachNetworkInterface",
            "ecr:DescribeImageScanFindings",
            "ssm:DescribeSessions",
            "ecr:GetLifecyclePolicyPreview",
            "ecr:GetDownloadUrlForLayer",
            "ecr:DescribeRegistry",
            "route53:ChangeResourceRecordSets",
            "ec2:DeleteNetworkInterface",
            "ecr:GetAuthorizationToken",
            "elasticloadbalancing:DeregisterTargets",
            "autoscaling-plans:DeleteScalingPlan",
            "servicediscovery:RegisterInstance",
            "servicediscovery:DeregisterInstance",
            "ec2:CreateNetworkInterface",
            "ec2:Describe*",
            "servicediscovery:Get*",
            "autoscaling-plans:DescribeScalingPlans",
            "ecr:BatchGetImage",
            "ecr:DescribeImages",
            "servicediscovery:UpdateInstanceCustomHealthStatus",
            "ec2:AttachNetworkInterface",
            "autoscaling-plans:CreateScalingPlan",
            "ecr:GetRepositoryPolicy",
            "elasticfilesystem:CreateMountTarget"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "VisualEditor3",
          "Effect" : "Allow",
          "Action" : "ssm:StartSession",
          "Resource" : [
            "arn:aws:ssm:::document/AmazonECS-ExecuteInteractiveCommand",
            "arn:aws:ecs:::task/*"
          ]
        }
      ]
    }
  )
}
resource "aws_iam_role_policy" "ecs_TaskRolePolicy" {
  name = "${var.stage}-${var.project}-ecs-TaskRolesPolicy"
  role = aws_iam_role.ecsTaskExecutionRole.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
{
    "Statement": [
        {
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "elasticfilesystem:CreateMountTarget"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "ssm:GetParameters",
                "secretsmanager:GetSecretValue",
                "kms:Decrypt"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:ssm:us-east-1:731936292250:parameter/*",
                "arn:aws:kms:us-east-1:731936292250:key/*"
            ]
        },
        {
            "Action": [
                "application-autoscaling:*",
                "ecs:DescribeServices",
                "ecs:UpdateService",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DeleteAlarms",
                "cloudwatch:DescribeAlarmHistory",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:DescribeAlarmsForMetric",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DisableAlarmActions",
                "cloudwatch:EnableAlarmActions",
                "iam:CreateServiceLinkedRole",
                "sns:CreateTopic",
                "sns:Subscribe",
                "sns:Get*",
                "sns:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}
  )
}