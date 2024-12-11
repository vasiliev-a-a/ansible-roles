# Role `addomain`

This role joins hosts to an Active Directory Domain:

1. It installs the required `packages_install`.
2. It configures _samba_ and _krb5-config_ packages.

   The changes are made by including config snippets into main files.

3. It invokes `net ads join` command.
4. It sets up _sssd.conf_ to serve NSS and PAM lookups from AD domain.

___

## Limitations

- Only Debian-based support is implementend at the moment.
- Only a single domain support is implementend at the moment.
- There is an assumption that a domain part of host's FQDN is the target domain -> every host will be joined to the `$(hostname -d)` domain.

___

## Dependencies

- `defaults` - to import common variables and handlers.

___

## Role Conent

- _defaults/main.yaml_:

  - `sssd_allow_groups` - list of the AD groups, whose members are allowed to access the linux hosts:

    - These will be allowed to _sudo_
    - These will be included into `simple_allow_groups` of _sssd.conf_

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `krb5_config_directory` | `/etc/krb5.conf.d` | Direcotry where _krb5_ configuration snippet will be created. |
  | `krb5_config_file` | `/etc/krb5.conf` | _krb5_ main configuration file. |
  | `krb5_config_snippet` | `{{ krb5_config_directory }}/{{ snippet_name }}`  | _krb5_ configuration snippet. |
  | `samba_config_directory` | `/etc/samba` | Direcotry where _samba_ configuration snippet will be created. |
  | `samba_config_file` | `/etc/samba/smb.conf` | _samba_ main configuration file. |
  | `samba_config_snippet` | `{{ samba_config_directory }}/{{ snippet_name }}.conf` | _samba_ configuration snippet. |
  | `sssd_config_directory` | `/etc/sssd/conf.d` | Direcotry required for _sssd.socket_ to start. |
  | `sssd_config_file` | `/etc/sssd/sssd.conf` | _sssd_ main configuration file. |

- _vars/debian.yaml_:

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `packages_install` | `[....]` | The list of packages this role will install. |
  | `pam_mkhomedir_module` | `pam_mkhomedir.so` | Name of the PAM _mkhomedir_ module. |
  | `sssd_service` | `sssd.service` | Identity of the sssd service. |

>☝️**Important:** These must be provided in any suitable way (`--extra-vars`, `vars_prompt`, `vars_files`, inventory):

- `join_user` - username (without domain suffix) to be used in `net ads join` invocation.
- `join_pass` - password to be used in `net ads join` invocation.

___

## Example Playbook

```yaml
---
- name: "Join computers to domain"
  hosts: linux:&domain
  vars_prompt:
  - name: join_user
    prompt: "Provide username (without the domain part) with permissions to join computer to domain"
    private: no
  - name: join_pass
    prompt: "Provide password for the specified username"
  roles:
  - role: addomain
    sssd_allow_groups: ["linux_administrators"]
...
```

___
