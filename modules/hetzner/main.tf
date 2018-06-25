resource "hcloud_server" "gitolite" {
  count = "${var.machine_count}"

  # When we have a single machine just name it by the prefix,
  # otherwise postfix the prefix with the padded index.
  name = "${var.machine_count == 1
    ? var.machine_prefix
    : "${format("%s-%02d", var.machine_prefix, count.index)}"
  }"

  image       = "${var.machine_image}"
  location    = "${var.machine_location}"
  server_type = "${var.machine_vm_type}"

  ssh_keys = ["${hcloud_ssh_key.active_keys.*.id}"]

  provisioner "salt-masterless" {
    local_state_tree  = "${path.root}/salt/"
    remote_state_tree = "/srv/salt/"

    connection {
      private_key = "${file(
        "${path.root}/ssh/${var.active_ssh_keys[0]}"
      )}"
    }
  }
}
