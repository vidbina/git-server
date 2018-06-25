# Usage

 - Initialize Terraform environment using `make init`
 - Validate configuration using `make validate`
 - Plan configuration using `make plan`
 - Apply configuration using `make apply`
 - ???
 - Tear-down configuration using `make destroy`

## Gitolite

> **NOTE**: This is the preferred method over plain git.

In order to use gitolite, one should provide an SSH key for the admin user at
the path `salt/gitolite/admin.pub`.

## Plain git

> **NOTE**: Just here for historic reasons. :wink:

### root

Create a `ssh` directory and copy or symlink the necessary public keys into
this directory named as `KEYNAME.pub`, where `KEYNAME` is a reference that we
will use to identify the keys in the Terraform configuration.

Create `keys.tfvars` and add the names to the `active_ssh_keys` variables.

```HCL
# keys.tfvars or any other *.tfvars file of your liking

# Suppose that ssh/vidbina.pub and ssh/robot.pub exist
active_ssh_keys = [
  "robot",
  "vidbina",
]
```

> NOTE: That the first keyname listed in `active_ssh_keys` will serve as the
> machine key. So in the case of a CI/CD pipeline, we will pick the first key
> in that list to run additional Terraform provisioners (e.g.: shell or
> salt-masterless)

### git

In order to setup the git user with the appropriate ssh keys, one may want to
populate the `salt/authorized_keys` file to contain all the authorized keys for
git access by concatenating public keys as demonstrated in the following example:

```
cat some_key.pub >> salt/authorized_keys
```

where some_key.pub is added to the authorized keys file.

Study the [OpenSSH documentation][auth-keys-openssh] for more information.

## Machine details

```HCL
# mech.hetzner.tfvars or any other *.tfvars file of your liking

machine_image = "centos-7"
machine_location = "fsn1"
machine_prefix = "git"
machine_type = "cx11"
```

[auth-keys-openssh]: https://www.ssh.com/ssh/authorized_keys/openssh
