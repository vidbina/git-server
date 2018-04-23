module "git_ssh" {
  source = "./modules/hetzner"

  api_token = "${var.api_token}"

  machine_name = "${var.machine_prefix}"

  machine_image = "${var.machine_image}"
  machine_location = "${var.machine_location}"
  machine_vm_type = "${var.machine_type}"

  active_ssh_keys = "${var.active_ssh_keys}"
}
