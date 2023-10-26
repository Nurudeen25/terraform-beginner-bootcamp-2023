# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT ROOT
|
├── main.tf           # everything else
├── variables.tf      # stores the structure of input variables
├── terraform.tfvars  # the data of variables we want to load in our terraform project
├── providers.tf      # defined required providers and their configuration
├── outputs.tf        # stores our outputs
└── README.md         # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Variables
## Terraform Cloud Variables

In Terraform we can set twomkind of variables:
- Environment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibility in the UI.

### Loading Terraform Inpur Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg.
`terraform -var user_id="my-user_id"`

### var-file flag

- TODO: research this flag

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence

## Dealing with Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastrcuture manually.

You can use terraform port but it won't work for all cloud resources.
You need check the terraform providers documentation for which resources support import.

### Fix Missing Resource with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/commands/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrastructure back into the expected state fixing 
Configuration Drift.