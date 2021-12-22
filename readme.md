# Project

This project is for creating super iam access for projects, managing GCP's organization user roles, and assigning members to each roles.

# Pre-requisites

Familiarize yourself with the [Recommended reading](#recommended-reading) section.

# Setup

This guide utilizes pre-defined helper scripts and Makefile. There are more feature of terraform not mentioned here.

## Prepare required files

1. create env file and tfvars file and modify content

```sh
$ export ENV=local-mja # change this per environment
$ cp .env.template ./.env
$ cp ./tfvars/terraform.tfvars.template ./tfvars/terraform-$ENV.tfvars
```

Step 2: prepare service account json key

1. Download API key of the SA assigned to this project.
1. Open [GCP IAM Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts)
1. Select your service account > Actions "Manage Keys" > "Add Key" > selet key type JSON
1. Save it under `auth/` with name pattern `key-env-$ENV.json` where $ENV is the name of the new/existing environment.

- Important note: make sure for existing envs, that you use the exact ENV file name for the scripts to work.

Step 3: Update files

1. Populate .env - [refer to this](#environment-variables)
1. Populate tfvar - [refer to this](#terraform-variables)

## Existing environment for already created resources

Note: `Makefile` will cd to `src` so the make commands needs relative path of files references inside `src`

```sh
# env = local-mja, change this
# optional append "reconfigure=y" to reconfigure init
$ make init new-workspace \
        reconfigure=y
```

### Verify that workspace was imported properly.

1. Change one simple variable inside tfvars/terraform-$ENV.tfvars, like name / description.
1. Run

## New environment for new resources

```sh
# env = local-mja, change this
# optionall append "reconfigure=y" to reconfigure init
$ make init new-workspace
```

## Creating or using new/secondary environment

For example, in local you already have `local-mja` and now you need to create `local-mja2`.

1. Create the tfvar for the new environment. Follow [Prepare required files](#prepare-required-files)

1. Update .env for the new environment. Follow [Prepare required files](#prepare-required-files)

1. Switch to new workspace.

```sh
$ make new-workspace
```

1. Initialize backend. Use the command from [Existing environment for already created resources](#existing-environment-for-already-created-resources)

## Commands

### Plan

```sh
$ make plan
```

### Apply

```sh
$ make apply
```

### Destroy

```sh
$ make destroy
```

### Others

There are other commands on the [Makefile](./Makefile) and https://www.terraform.io/cli/commands.

Note: Each `make` command triggers `./unsetenv.sh` and `./setenv` to refresh and validate env variables.

Beware: Apart from auto clear env and env validation mentioned on the 'note' above, `source ./setenv.sh && ` is prepended for each terraform cli command to load the `.env` environment variables for the same shell as terraform cli. Not using it on manual terraform command may cause wrong variables/old value.

# Contributing

## When to define variables

| Variable                          | put in                                                                                                                                                                                                                                                    |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Used for the project resources    | `src/variables.tf`, optional on `tfvars/terraform.tfvars.tempalte`                                                                                                                                                                                        |
| Not used for resources generation | `.env`                                                                                                                                                                                                                                                    |
| Secrets / password                | Still update [related files](#variables). Actual values should not be committed. For local development: utilise `.env` or system `.bashrc`, `.profile` or append before each command `source ./setenv.sh && terraform plan -var="mysql_db_pass=password"` |

## variables

For any update of the project please always

1. Format before commit `terraform fmt -recursive`
1. Update related files
   - `.env.template`
   - `tfvars/./terraform.tfvars.template`
   - `setenv.sh`
   - `unsetenv.sh`

## environment variables

| variable                       | description                                                                                                      |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| ENV                            | The environment name. This is also used on the tfstate remote backend path                                       |
| TFSTATE_BUCKET                 | Assigned storage bucket for the shared tfstate                                                                   |
| GOOGLE_APPLICATION_CREDENTIALS | Service account key or other google credentials that have enough permission to execute all task of this project. |

## Terraform Variables

[Variable definitions Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files) in `tfvars/terraform-$ENV.tfvars` file is one way to provide input variables declared on the [variables.tf](./src/variables.tf) file. Description and documentation of each variable is also on the [variables.tf](./src/variables.tf) file.

# References

## Recommended reading

- https://www.terraform.io/cli/commands
- https://learn.hashicorp.com/terraform
- https://www.terraform.io/language/values/variables
