<!-- This file is used by `mdctl`. Make all changes to `README.yaml` and run `mdctl build` to rebuild this file. -->



<h1 align="center">docker-atlantis-terragrunt</h1>



<h4 align="center">A Docker image for running Atlantis with Terragrunt</h4>



<p align="center">

[![License](https://img.shields.io/github/license/scalefactory/docker-atlantis-terragrunt.svg)](https://github.com/scalefactory/docker-atlantis-terragrunt) 

</p>



<p align="center">
 <a href="https://www.runatlantis.io/" target="_blank">Atlantis</a>  • <a href="https://github.com/gruntwork-io/terragrunt" target="_blank">Terragrunt</a> <a href="https://github.com/terraform-aws-modules/terraform-aws-atlantis" target="_blank">Atlantis Terraform module</a>  • <a href="https://github.com/scalefactory/docker-atlantis-terragrunt/issues" target="_blank">Report a bug</a>  •
</p>



## :sparkles: Features
- Docker image to run Terragrunt with Atlantis
- SSH key support to access private repositories




## :bulb: Quick Start
Deploy the reference [Atlantis Terraform module](https://github.com/terraform-aws-modules/terraform-aws-atlantis)

Tweak the `custom_environments_secret_secrets` and `atlantis_image` variables. Put your private SSH key into AWS secrets manager under the `/atlantis/github/user/private_ssh_key` path

```
# terraform-aws-modules/terraform-aws-atlantis
...
custom_environment_secrets = [
  {
    name  = "GITHUB_USER_SSH_KEY"
    valueFrom = "/atlantis/github/user/private_ssh_key"
  }
]
atlantis_image             = "scalefactory/docker-atlantis-terragrunt:v0.19.20"
...
```

*Note:* You will need to grant the Fargate task permission to read the secret above.


## :page_facing_up: License
docker-atlantis-terragrunt is an open-sourced software licensed under the [MIT license](LICENSE.md).



## :star: Contributors

|  [![Steve Porter][steveporter92_avatar]][steveporter92_homepage]<br/>[Steve Porter][steveporter92_homepage] |
|---|

  [steveporter92_homepage]: https://github.com/steveporter92
  [steveporter92_avatar]: https://github.com/steveporter92.png?size=150



_This README was generated with :heart: by [**mdctl**](https://github.com/mdctl/mdctl)_