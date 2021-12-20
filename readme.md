# Project

This project is for creating super iam access for projects and managing organization's GCP user roles

# Setup

## Prepare required files

Step 1: create env file and tfvars file and modify content

```sh
$ cp .env.template ./.env
$ cp ./tfvars/terraform.tfvars.template ./tfvars/terraform-$ENV.tfvars
```

Step 2: prepare service account json key

- Download API key of the SA assigned to this project.
- Save it under `auth/` with name pattern `key-env-$ENV.json` where $ENV is the name of the new/existing environment.
  - Important note: make sure for existing envs, that you use the exact ENV file name for the scripts to work.

## Existing environment for already created resources

Note: `Makefile` will cd to `src` so the make commands needs relative path of files references inside `src`

```sh
# env = local-mja, change this
# optionall append "reconfigure=y" to reconfigure init
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

Create the tfvar for the new environment. Follow [Prepare required files](#prepare-required-files)

Update .env for the new environment. Follow [Prepare required files](#prepare-required-files)

Switch to new workspace.

```sh
$ make new-workspace
```

Use the command from [Existing environment for already created resources](existing-environment-for-already-created-resources)

## Plan

```sh
# env = local-mja, change this
$ ENV=local-mja \
    make plan
```

## Apply

```sh
# env = local-mja, change this
$ ENV=local-mja \
    make apply
```

## Destroy

```sh
# env = local-mja, change this
$ ENV=local-mja \
    make destroy
```

# References:

https://www.terraform.io/cli/commands
