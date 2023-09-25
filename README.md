# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage!!:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The General format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR version when you make incompatible API changes
- **MINOR version when you add functionality in a backward compatible manner
- **PATCH version when you make backward compatible bug fixes

## Install the Terraform CLI

### Cosiderations with theTerraform CLI changes
The Terraform CLI installation instructions have chanmged due to gpg keyring changes. So i needed refer to the latest install CLI 
instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is build against Ubuntu Linux Distribution.
Please consider checking your Linux Distribution  and change according to distribution needs

[How to check OS version in Linux](https://opensource.com/article/18/6/linux-version)

Example of checking OS

```sh
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues i notice that the bash scripts steps were a considerable amount
more code. So i decided to create a bash script to install the Terraform CLI.

This bash script is location here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml))tidy.
- This allow us an easier to debug and execute manaully Terraform CLI install
- This will allow better protability for other projects that need to install Terraform CLI.

### Shebang Considerations

A Shebang (pronounce Sha bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search tje user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

if we are uasing a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permission Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

We can list our all Env Variables (Env Vars) Usinging the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
within a bash script we can set env without writing export eg.
```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

## Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open new bash terminals in VSCode it will not be aware of env vars that you 
have set in another window.

If you want to Env Vars to persist across all future bash teminals that are open you 
need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storgae.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in
those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env 
vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDAR4NWWW6JD3M5YO7QQ",
    "Account": "123456677883",
    "Arn": "arn:aws:iam::123456677883:user/Dan"
}
```

We need to generate AWS CLI credentials  from IAM User in order to use AWS CLI

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at 
[registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will
allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular,
portable and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

### Terraform Init

At the start of a new terraform project we will run
`terraform init` to download the binaries for the 
terraform providers that we'll use in this project,

#### Terraform Plan

This will generate out a changeset, about the state of our infrastructure and 
what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore
outputting.

### Terraform Fmt

Running this command in the directory containing your Terraform configuration files will automatically format all the files in that directory
and its subdirectories according to the formatting rules defined by Terraform.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be 
execute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can
provide the auto approve flag eg. `terraform apply --auto-approve`

### Terraform Lock Files

`.terraforn.lock.hcl` contains the locked versioning for the providers or modules
that should be used with this project.

The Terraform lock file should be committed to your Version Control System (VSC) eg. GitHub

### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive dtate/

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.