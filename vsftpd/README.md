# Role `vsftpd`

This role deploys FTP server powered by _vsftpd_:

1. It installs _vsftpd_ package.
2. It setups all required parts - user accoounts, directries:

   - `ftp_users` are created as system users. There were multiple reasons to not implement _virtula users_ in mine environment:

     - It is perfectly compatible with _sftp_ provided by _OpenSSH_, thus one more supported protocol automagically
     - We are relying on the filesystem permissions for access restriction, thus users do require unique identity
     - Group membership is used to implement `admin` users: they are members of all other user groups
     - User's homedir and GECOS is also used

## Limitations

- Only Debian-based OS support is implementend at the moment.

## Dependencies

- `defaults`: to import common variables and handlers.

## Role Variables

All users, that should be provisioned, must be specified in the `ftp_users` variable as a list of structures with following fields:

- `name` - a login and display name.
- `id` - this will be used as user UID, and its group GID.
- `password` - plain text password.

  ☝️**Important:** Use `ansible-vault` to encrypt a playbook or inventory.

- `role` - one of `user` or `admin`:

  - `user` - upon login will be isolated to their virtual root folder, which is their home catalog.
  - `admin` - home catalog is `ftp_root`, also become members of all other user groups to gain access to their catalogs.

- _defaults/main.yaml_:

  - `ftp_root` - the global root folder.
  - `ftp_user{name, uid}` - user that will run _vsftpd_ process.
  - `ftp_group{name, gid}` - group of the user, that will run _vsftpd_ process; also is the group owner of the `ftp_root`.
  - `vsftpd_listen_port` - port to listen for incoming connections.
  - `vsftpd_pasv_min_port` - the starting port for PASV range.
  - `vsftpd_pasv_max_port` - the ending port for PASV range.
  - `vsftpd_log_file` - path to log file.
  - `vsftpd_xferlog_file` - path to transfer sessions log file.
  - `vsftpd_config_file` - main _vsftpd_ configuration file.
  - `vsftpd_config_directory` - folder with _vsftpd_ configuration files.
  - `vsftpd_rsa_cert_file` - where to store `vsftpd_rsa_cert`.
  - `vsftpd_rsa_cert` - PEM-encoded certificate.
  - `vsftpd_config_extra` - if defined, this block will be added into configuration file _"as is"_.
  - `vsftpd_rsyslog_extra` - if defined, this block will be added into rsyslog configuration file _"as is"_.

- _vars/debian.yaml_:

  - `packages_install` - packages that this role will install.
  - `vsftpd_service` - identity of the vsftpd service.

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
