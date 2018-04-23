TERRAFORM_HETZNER_HCLOUD_GIT=github.com/hetznercloud/terraform-provider-hcloud
#TERRAFORM_1AND1_=github.com/1and1/terraform-provider-oneandone

HETZNER_VAR_FILES_ARGS=\
	-var-file=secret.hetzner.tfvars \
	-var-file=mech.hetzner.tfvars \
	-var-file=keys.tfvars

HETZNER_TERRAFORM_OUTPUT_FILE=git.hetzner.tfout

#GOPATH_BIN=$(realpath GOPATH)/bin

fetch_terraform_hcloud:
	go get ${TERRAFORM_HETZNER_HCLOUD_GIT}

fetch: fetch_terraform_hcloud

init:
	terraform init \
		-plugin-dir=${GOPATH_BIN}

console:
	terraform console \
		${HETZNER_VAR_FILES_ARGS}

plan:
	terraform plan \
		-out=${HETZNER_TERRAFORM_OUTPUT_FILE} \
		${HETZNER_VAR_FILES_ARGS}

apply:
	terraform apply \
		${HETZNER_TERRAFORM_OUTPUT_FILE}

destroy:
	terraform destroy \
		-auto-approve \
		${HETZNER_VAR_FILES_ARGS}

validate:
	terraform validate \
		${HETZNER_VAR_FILES_ARGS}
	
setup: fetch init

.PHONY: \
	apply \
	console \
	destroy \
	fetch \
	fetch_terraform_hcloud \
	plan \
	setup \
	validate
