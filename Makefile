APP_NAME=tf-gcp-super-iam
LOCATION=src


# main tf commands
init: check-credentials check-env check-tfstate-bucket
# args: reconfigure=y to re-init
	cd $(LOCATION) && \
	terraform init \
		-backend-config="bucket=$(TFSTATE_BUCKET)" \
		-backend-config="prefix=$(ENV)/$(APP_NAME)" \
		$(if $(findstring $(reconfigure), y), "-reconfigure", )

plan: check-credentials check-env switch-workspace
	GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-$(ENV).json \
	cd $(LOCATION) && \
	terraform plan \
		-var-file="../tfvars/terraform-$(ENV).tfvars" \
		-out="../plans/plan.$(ENV).out"

apply: check-credentials check-env switch-workspace
	GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-$(ENV).json \
	cd $(LOCATION) && \
	terraform apply "../plans/plan.$(ENV).out"

destroy: check-credentials check-env switch-workspace
	GOOGLE_APPLICATION_CREDENTIALS=../auth/key-env-$(ENV).json \
	cd $(LOCATION) && \
	terraform plan \
		-destroy \
		-var-file="../tfvars/terraform-$(ENV).tfvars" \
		-out="./plans/plan.$(ENV).out"
	terraform apply "../plans/plan.$(ENV).out"

reset: delete-workspace init new-workspace


# utils

new-workspace:
	terraform workspace new $(ENV)

switch-workspace:
	terraform workspace select $(ENV)

delete-workspace:
	terraform workspace select default
	terraform workspace delete $(ENV)


check-env:
ifndef ENV
	$(error ENV is undefined)
endif

check-tfstate-bucket:
ifndef TFSTATE_BUCKET
	$(error TFSTATE_BUCKET is undefined)
endif

check-credentials:
ifndef GOOGLE_APPLICATION_CREDENTIALS
	$(error GOOGLE_APPLICATION_CREDENTIALS is undefined)
endif

check-location:
ifndef LOCATION
	$(error LOCATION is not set)
endif
