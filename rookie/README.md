# Role `rookie`

This role brings new hosts (rookies) under control of Ansible:

1. It installs _rsync_ package to satisfy _ANSIBLE.POSIX.SYNCHRONIZE_ module.
2. It enables pam umask module, so umask in account GECOS field gets respected.
3. It creates a user account for management purposes:

   - The user's password will be locked.
   - The user's _~/.ssh/authorized_keys_ will be populated to allow public key authentication.
   - The user will be allowed to login with ssh only from `ansible_controller_addresses`.
   - The user will be permitted to _sudo_ any command without password prompt.

## Limitations

- Only Debian-based OS support is implementend at the moment.

## Dependencies

- `defaults`: to import common variables and handlers.

## Role Variables

`ansible_controller_addresses` defines a list of hosts, from which `ansible_account_user`  
is allowed to connect. If not provided explicitly, it will be initialized to ipv4 addresses  
of the host currently executing the playbook during the preflight task.

- _defaults/main.yaml_:

  - `ansible_become_pass` - password that is used to elevate privileges
  - `ansible_account_user`, `ansible_account_group`, `ansible_account_uid`, `ansible_account_home` - options for management account.
  - `authorized_keys_extra` - these ones will be included into _~/.ssh/authorized_keys_.

     Any of _~/.ssh/id\_{dsa,rsa,ecdsa,ed25519}.pub_ of the user, who is executing a playbook, is also included.

- _vars/debian.yaml_:

  - `packages_install` - list of packages that this role will install.
  - `pam_umask_module` - name of the _umask_ PAM module.

## Example Playbook

```yaml
---
- name: "Prepare new nodes to be managed by Ansible"
  hosts: newcommers
  vars:  # Consider putting these somewhere into inventory, or passing them with `-e` flags.
    ansible_user: "<UserToConnectWith>"
    ansible_password: "<PasswordToConnectWith>"
  roles:
    - role: rookie
      ansible_controller_addresses:
      - "172.16.1.10"
      - "host.323.pri"
      authorized_keys_extra:
      - "<boss_key>"
      - "<my_key>"
      - "<team_key>"
...
```
