# Terraform Modules for GitHub Actions Secrets and Variables

This Terraform modules creates GitHub Actions secrets and variables for a specified repository. The module allows you to specify the name, and value of the secrets and variables.

## Usage

``` hcp
module "variables" {
  source          = "git::https://github.com/Usaldudo/tf-github-modules.git//modules/gh-variables"
  variables       = [{
    "Variable1" = "Value1"
  }]
  repository = myreponame
  owner      = myusername
}
module "secrets" {
  source            = "git::https://github.com/Usaldudo/tf-github-modules.git//modules/gh-secrets"
  encrypted_secrets = {
    "Secret1" = "Ri0xrkcROh1AvV209dZrgtgG9eOdXOdUIjX8ErVOUxD3XWHFU7mvd106+XVQIoDWb2wFIuRB9tippB09ieyMyw=="
  }
  plaintext_secrets = {
    "MY_SECRET" = "42"
  }
  repository        = myreponame
  owner             = myusername
}
module "environments" {
  source       = "git::https://github.com/Usaldudo/tf-github-modules.git//modules/gh-envs"
  environments = environments = [{
    name = "dev"
    deployment_branch_policy = {
      protected_branches          = true
      custom_branch_policies = false
    }
    variables = {
      "Var0" = "val0"
    }
    plaintext_secrets = {
      "MY_ENV_SECRET" = "secret"
    }
    encrypted_secrets = {
      "MY_ENV_ENC_SECRET" = "MTIzNDU="
    }
  }]
  repository   = myreponame
  owner        = myusername
}
```

```bash
./encrypt_secret.py "<repo_public_key>" "encrypted-secret"
```

## Inputs

The following inputs are supported:

- `repository` (required): The name of the repository for which to create the secrets and variables.
- `owner` (required): The name of the repository owner for which to create the secrets and variables.
- `encrypted_secrets` (optional): A map of encrypted secrets to create.
- `plaintext_secrets` (optional): A map of secrets to create.
- `variables` (optional): A map of variables to create.
- `secrets` (optional): A map of secrets to create.
- `environments` A list of environments to create

## Outputs

- `repo_public_key` (string): A public key, which you need to encrypt secrets. [Api docs](https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28#get-a-repository-public-key)

## Note

These modules requires that you have appropriate permissions to create secrets and variables in the specified repository.
