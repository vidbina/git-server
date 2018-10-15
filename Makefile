TF_VAR_FILES_ARGS=\
	-var-file=secret.hetzner.tfvars \
	-var-file=mech.hetzner.tfvars \
	-var-file=keys.tfvars

HETZNER_TERRAFORM_OUTPUT_FILE=git.hetzner.tfout

# Constants for the duration of this make run
HOST!=terraform output -json ip4_addrs | jq -r '.value.git'
STAMP!=date +"%Y%m%d_%H%M%S"

SSH_KEY?=admin
SSH_USER?=root
SSH_COMMAND=ssh -i ssh/${SSH_KEY}

# The following Rsync arguments are used:
#  -a archive mode; equals -rlptgoD
#    -r recurse into directories
#    -l copy symlinks as symlinks
#    -p preserve permissions
#    -t preserve modification times
#    -g preserve group
#    -o preserve owner (super-user only)
#    -D same as --devices --specials
#      --devices preserve device files (super-user only)
#      --specials preserve special files
#  -P same as --partial --progress
#    --partial keep partially transferred files
#    --progress show progress during transfer
#  -h output numbers in a human-readable format
#  -n perform a trial run with no changes made
#  -v increase verbosity
#  --stats prints a verbose set of statistics to provide extra insight into deltra-tranfer alg
RSYNC_ARGS=-aPh
RSYNC_DEBUG_ARGS?=-vv

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
	${SSH_COMMAND} ${SSH_USER}@${HOST}

backup_repos:
	rsync ${RSYNC_ARGS} ${RSYNC_DEBUG_ARGS} \
		-e "${SSH_COMMAND}" \
		${SSH_USER}@${HOST}:/home/git/repositories \
		backups/${STAMP}.repositories/

backup_all:
	rsync ${RSYNC_ARGS} ${RSYNC_DEBUG_ARGS} \
		-e "${SSH_COMMAND}" \
		${SSH_USER}@${HOST}:/home/git/. \
		backups/${STAMP}.repositories/

.PHONY: \
	apply \
	backup_all \
	backup_repos \
	console \
	destroy \
	fetch \
	fetch_terraform_hcloud \
	plan \
	refresh \
	setup \
	ssh \
	validate
