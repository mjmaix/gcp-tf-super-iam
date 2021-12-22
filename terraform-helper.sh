#! /bin/bash


# usage example 
# $ ./terraform-helper.sh -chdir=$LOCATION refresh -var-file="../tfvars/terraform-$ENV.tfvars"
# $ ./terraform-helper.sh -chdir=$LOCATION validate -var-file="../tfvars/terraform-$ENV.tfvars"

# run prog with arguments
source ./unsetenv.sh && \
source ./setenv.sh && \
terraform "$@"