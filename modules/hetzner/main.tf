resource "hcloud_server" "git-01" {
  name = "${var.machine_name}"

  server_type = "${var.machine_vm_type}"
  location = "${var.machine_location}"
  image = "${var.machine_image}"

  ssh_keys = ["${hcloud_ssh_key.active_keys.*.id}"]
}

output "git_keys" {
  value = "${hcloud_server.git-01.ssh_keys}"
}
