# Usage

 - Install all terraform plugins using `make fetch`
 - Init terraform environment using `make init`
 - Validate setup using `make validate`
 - Plan setup using `make plan`
 - Apply setup using `make apply`
 - ???
 - Tear-down setup using `make destroy`

## SSH Keys

Create a `ssh` directory and copy or symlink the necessary public keys into
this directory named as `KEYNAME.pub`, where `KEYNAME` is a reference that we
will use to identify the keys in the terraform code.

Create `keys.tfvars` and add the names to the `active_ssh_keys` variables.

```HCL
# keys.tfvars or any other *.tfvars file of your liking

# Suppose that ssh/vidbina.pub and ssh/robot.pub exist
active_ssh_keys = [
  "robot",
  "vidbina",
]
```

## Machine details

```HCL
# mech.hetzner.tfvars or any other *.tfvars file of your liking

machine_image = "centos-7"
machine_location = "fsn1"
machine_prefix = "git"
machine_type = "cx11"
```
