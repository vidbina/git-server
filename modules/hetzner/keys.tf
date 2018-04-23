resource "hcloud_ssh_key" "active_keys" {
  count = "${length(var.active_ssh_keys)}"

  name = "${var.active_ssh_keys[count.index]}"
  public_key = "${
    file("${path.root}/ssh/${var.active_ssh_keys[count.index]}.pub")
  }"
}
