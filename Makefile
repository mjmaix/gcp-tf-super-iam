SHELL := /bin/bash

###
# References:
# `$$VAR` - from shell, setenv.sh https://stackoverflow.com/a/67345506
###



# main tf commands

###
# init params
# (optional) args: reconfigure=y to re-init
###
init: validate-envs
	source ./setenv.sh && \
	terraform \
		-chdir=$$LOCATION \
		init \
			-backend-config="bucket=$$TFSTATE_BUCKET" \
			-backend-config="prefix=$$ENV/$$APP_NAME" \
			$(if $(findstring $(reconfigure), y), "-reconfigure", )

plan: validate-envs switch-workspace
	source ./setenv.sh && \
	terraform \
		-chdir=$$LOCATION \
		plan \
			-var-file="../tfvars/terraform-$$ENV.tfvars" \
			-out="../plans/plan.$$ENV.out"

apply: validate-envs switch-workspace
	source ./setenv.sh && \
	terraform \
		-chdir=$$LOCATION \
		apply \
			"../plans/plan.$$ENV.out"

destroy-plan: validate-envs switch-workspace
	source ./setenv.sh && \
	terraform \
		-chdir=$$LOCATION \
		plan \
			-destroy \
			-var-file="../tfvars/terraform-$$ENV.tfvars" \
			-out="../plans/plan.$$ENV.out"
	
destroy: validate-envs switch-workspace
	source ./setenv.sh && \
	terraform \
		-chdir=$$LOCATION \
		apply \
		-destroy \
		-var-file="../tfvars/terraform-$$ENV.tfvars"

validate: validate-envs 
	source ./setenv.sh && \
	terraform \
			-chdir=$$LOCATION \
			validate

reset: delete-workspace init new-workspace

# utils

new-workspace: validate-envs 
	source ./setenv.sh && terraform workspace new $$ENV

switch-workspace: validate-envs 
	source ./setenv.sh && echo "ENV is $$ENV"
	source ./setenv.sh && terraform workspace select $$ENV

delete-workspace: validate-envs 
	source ./setenv.sh && terraform workspace select default
	source ./setenv.sh && terraform workspace delete $$ENV

validate-envs:
	$(source ./unsetenv.sh && source ./setenv.sh || echo "Command fialed $$?"; exit 1)
