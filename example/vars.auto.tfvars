variables = {
  "Variable1": "Value1"
  "Variable2": "Value2"
}
plaintext_secrets = {
  "MY_SECRET" = "42"
  "OWN_TOKEN" = "12345"
}
encrypted_secrets = {
  "Secret1" = "Ri0xrkcROh1AvV209dZrgtgG9eOdXOdUIjX8ErVOUxD3XWHFU7mvd106+XVQIoDWb2wFIuRB9tippB09ieyMyw=="
}
environments = [{
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