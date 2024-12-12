# Role `addomain`

This role joins hosts to an Active Directory Domain:

1. It installs the required `packages_install`.
2. It configures **samba** and **krb5-config** packages.

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

    - These will be allowed to **sudo**
    - These will be included into `simple_allow_groups` of _sssd.conf_

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `krb5_config_directory` | `/etc/krb5.conf.d` | **krb5** drop-in configuration directory. |
  | `krb5_config_file` | `/etc/krb5.conf` | **krb5** main configuration file. |
  | `samba_config_directory` | `/etc/samba` | **samba** drop-in configuration directory. |
  | `samba_config_file` | `/etc/samba/smb.conf` | **samba** main configuration file. |
  | `sssd_config_directory` | `/etc/sssd/conf.d` | **sssd** drop-in configuration directory. |
  | `sssd_config_file` | `/etc/sssd/sssd.conf` | **sssd** main configuration file. |
  | `sssd_krb5_config_snippet` | `{{ krb5_config_directory }}/{{ snippet_name }}`  | **krb5** configuration snippet. |
  | `sssd_samba_config_snippet` | `{{ samba_config_directory }}/{{ snippet_name }}.conf` | **samba** configuration snippet. |
  | `sssd_logrotate_config_snippet` | `{{ logrotate_config_snippet }}` | **logrotate** configuration snippet. |
  | `sssd_sudoers_config_snippet` | `{{ sudoers_config_snippet }}` | **sudo** configuration snippet. |

- _vars/debian.yaml_:

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `packages_install` | `[...]` | The list of packages this role will install. |
  | `pam_mkhomedir_module` | `pam_mkhomedir.so` | Identity of the **mkhomedir** PAM module. |
  | `sssd_service` | `sssd.service` | Identity of the **sssd** service. |

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
