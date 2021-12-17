# Project

Example project on how to use the shared TF State for new projects.

Read [usage](../docs/usage.md) for how to setup

# Setup new environment

```sh
$ export ENV=local-mja
$ echo $ENV
$ cp ./tfvars/terraform.tfvars.template ./tfvars/terraform-$ENV.tfvars

$ cd src
```

## Init

```sh
# env = local-mja, change this
# optionall append "reconfigure=y" to reconfigure init
$ ENV=local-mja \
    TFSTATE_BUCKET=apps-shared-tfstate \
    GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-local-mja.json \
    make init new-workspace
```

## Plan

```sh
# env = local-mja, change this
$ ENV=local-mja \
    TFSTATE_BUCKET=apps-shared-tfstate \
    GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env--local-mja.json \
    make plan
```

## Apply

```sh
# env = local-mja, change this
$ ENV=local-mja \
    TFSTATE_BUCKET=apps-shared-tfstate \
    GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-local-mja.json \
    make apply
```

## Destroy

```sh
# env = local-mja, change this
$ ENV=local-mja \
    TFSTATE_BUCKET=apps-shared-tfstate \
    GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-local-mja.json \
    make destroy
```
