# Role `vsftpd`

This role deploys FTP server powered by _vsftpd_:

1. It installs _vsftpd_ package.
2. It setups all required parts - user accoounts, directries:

   - `ftp_users` are created as system users. There were multiple reasons to not implement _virtula users_ in mine environment:

     - It is perfectly compatible with _sftp_ provided by _OpenSSH_, thus one more supported protocol automagically
     - We are relying on the filesystem permissions for access restriction, thus users do require unique identity
     - Group membership is used to implement `admin` users - they are members of all other user groups
     - User's homedir and GECOS is also used

___

## Limitations

- Only Debian-based OS support is implementend at the moment.

___

## Dependencies

- `defaults` - to import common variables and handlers.

___

## Role Content

All users, that should be provisioned, must be specified in the `ftp_users` variable as a list of structures with following fields:

- `name` - a login and display name.
- `id` - this will be used as user UID, and its group GID.
- `password` - plain text password.

  >☝️**Important:** Use `ansible-vault` to encrypt a playbook or inventory.

- `role` - one of `user` or `admin`:

  - `user` - upon login will be isolated to their virtual root folder, which is their home catalog.
  - `admin` - home catalog is `ftp_root`, also become members of all other user groups to gain access to their catalogs.

- _defaults/main.yaml_:

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `ftp_root` | `/etc/vsftpd.conf.d` | The global root folder. |
  | `ftp_user{name, uid}` | `{name: 'ftp-user', uid: 200}` | User that will run _vsftpd_ process. |
  | `ftp_group{name, gid}` | `{name: 'ftp-users', gid: 200}` | Group of the user, that will run _vsftpd_ process; also is the group owner of the `ftp_root`. |
  | `vsftpd_config_directory` | `/etc/vsftpd.conf.d` | Folder with _vsftpd_ configuration files. |
  | `vsftpd_config_extra` |  | If defined, this block will be added into configuration file _"as is"_. |
  | `vsftpd_config_file` | `/etc/vsftpd.conf` | Main _vsftpd_ configuration file. |
  | `vsftpd_listen_address` | `0.0.0.0` | Address to listen for incoming connections. |
  | `vsftpd_listen_port` | `21` | Port to listen for incoming connections. |
  | `vsftpd_log_file` | `/var/log/vsftpd.log` | Path to log file. |
  | `vsftpd_pasv_min_port` | `10000` | The starting port for PASV range. |
  | `vsftpd_pasv_max_port` | `12000` | The ending port for PASV range. |
  | `vsftpd_rsa_cert_file` | `{{ vsftpd_config_directory }}/cert.pem` | Where to store `vsftpd_rsa_cert`. |
  | `vsftpd_rsa_cert` | `-----CERTIFICATE CONTENT HERE----` | PEM-encoded certificate. |
  | `vsftpd_rsyslog_extra` |  | If defined, this block will be added into rsyslog configuration file _"as is"_. |
  | `vsftpd_xferlog_file` | `/var/log/xferlog` | Path to transfer sessions log file. |

- _vars/debian.yaml_:

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `packages_install` | `vsftpd` | Packages that this role will install. |
  | `pam_umask_module` | `pam_umask.so` | Name of the _umask_ PAM module. |
  | `vsftpd_service` | `vsftpd.service` | Identity of the vsftpd service. |

___

## Example Playbook

```yaml
---
- name: "Deploy FTP servers"
  hosts: ftp-srv-01,ftp-srv-02
  serial: 1
  max_fail_percentage: 49
  roles:
    - role: vsftpd
      ftp_users:
        - name: user1
          id: 2001
          password: test1
          role: user
        - name: user2
          id: 2002
          password: test2
          role: admin
  post_tasks:
  - name: "Wait for server `{{ inventory_hostname }}` is ready"
    wait_for:
      connect_timeout: 10
      sleep: 10
      host: "{{ inventory_hostname }}"
      port: 21
      search_regex: '^220\ \(vsFTPd'
...
```

___
