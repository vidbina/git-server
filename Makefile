TF_VAR_FILES_ARGS=\
	-var-file=secret.hetzner.tfvars \
	-var-file=mech.hetzner.tfvars \
	-var-file=keys.tfvars

HETZNER_TERRAFORM_OUTPUT_FILE=git.hetzner.tfout

SSH_KEY?=admin
SSH_USER?=root

init:
	terraform init

console:
	terraform console \
		${TF_VAR_FILES_ARGS}

plan:
	terraform plan \
		-out=${HETZNER_TERRAFORM_OUTPUT_FILE} \
		${TF_VAR_FILES_ARGS}

apply:
	terraform apply \
		${HETZNER_TERRAFORM_OUTPUT_FILE}

destroy:
	terraform destroy \
		-auto-approve \
		${TF_VAR_FILES_ARGS}

refresh:
	terraform refresh \
		${TF_VAR_FILES_ARGS}

validate:
	terraform validate \
		${TF_VAR_FILES_ARGS}
	
setup: fetch init

ssh:
	ssh -i ssh/${SSH_KEY} ${SSH_USER}@`terraform output -json ip4_addrs | jq -r '.value.git'`

.PHONY: \
	apply \
	console \
	destroy \
	fetch \
	fetch_terraform_hcloud \
	plan \
	refresh \
	setup \
	ssh \
	validate
