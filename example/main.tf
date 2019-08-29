module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 2.0"

  name = "atlantis"

  # VPC
  cidr            = "10.20.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]

  # DNS (without trailing dot)
  route53_zone_name = "${aws_route53_zone.atlantis.name}"

  # Atlantis
  atlantis_github_user       = var.github_user
  atlantis_github_user_token = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["token"]
  atlantis_repo_whitelist    = ["github.com/scalefactory/*"]
  atlantis_image             = "scalefactory/docker-atlantis-terragrunt:v0.19.20"
  allow_repo_config          = "true"

  # Allow custom workflows and configuratble apply requirements
  custom_environment_variables = [
    {
      name  = "ATLANTIS_REPO_CONFIG_JSON"
      value = "{\"repos\":[{\"id\":\"/.*/\", \"allowed_overrides\":[\"workflow\",\"apply_requirements\"], \"allow_custom_workflows\":true}]}"
    }
  ]

  # Read private SSH Key from sercrets manager
  custom_environment_secrets = [
    {
      name  = "GITHUB_USER_SSH_KEY"
      valueFrom = "/atlantis/github/user/private_ssh_key"
    }
  ]

  # Atlantis Task policies
  policies_arn = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

resource "aws_route53_zone" "atlantis" {
  name = var.domain
}

data "aws_secretsmanager_secret" "secret" {
  arn = var.github_secret_token_arn
}

data "aws_secretsmanager_secret_version" "secret" {
  secret_id = data.aws_secretsmanager_secret.secret.id
}
