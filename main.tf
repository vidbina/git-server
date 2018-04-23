module "git_ssh" {
  source = "./modules/hetzner"

  api_token = "${var.api_token}"

  machine_count = "${var.machine_count}"
  machine_image = "${var.machine_image}"
  machine_location = "${var.machine_location}"
  machine_prefix = "${var.machine_prefix}"
  machine_vm_type = "${var.machine_type}"

  active_ssh_keys = "${var.active_ssh_keys}"
}
