# Infrastructure as a Code

## Deployment

- https://app.terraform.io/app/cloud-9-aviation/workspaces/terraform

## 1Password

```bash
sudo bash -c "op completion $(basename $SHELL) > /etc/bash_completion.d/op" # TODO: Move to Dockerfile
op account add --address my.1password.com # TODO: Run on container start, if necessary.
eval $(op signin) # TODO: Run on container start
```

* [Use 1Password to securely authenticate Terraform Beta](https://developer.1password.com/docs/cli/shell-plugins/terraform/)

```bash
op plugin init terraform
echo "source /home/vscode/.config/op/plugins.sh" >> ~/.bashrc && source ~/.bashrc
```

## Terraform

```bash
# op inject -i .env -o op.auto.tfvars
op inject -i op.auto.vars.tpl -o op.auto.tfvars
terraform init
terraform plan
# op run --no-masking --env-file="./.env" -- terraform plan
# terraform plan -var="github_token=$(op read "op://Cloud 9 Aviation LLC/GitHub Personal Access Token/token")"
```

```bash
terraform import module.github.github_repository.terraform terraform
```
