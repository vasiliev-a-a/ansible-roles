# Role `defaults`

The sole purpose of this role is to hold various frequently used variables and handlers.

It can be either included as a dependency, or assigned explicitly within a playbook.

✍️**Note:** Although there is a lot of variables, there is only one action.  
That is enforcing the drop-in configuration model for the _sudo_.  
All other usecases of variables are left to specialized roles.

## Limitations

- Only Debian-based OS support is implementend at the moment.

## Role Content

- _defaults/main.yaml_:

| Variable | Default | Description |
|:---------|:-------:|:------------|
| `snippet_prefix` | `501` | Prefix that will be used to build names of configuration snippets |
| `sshd_config_file` | `/etc/ssh/sshd_config` | Main _sshd_ configuration file |
| `pam_common_session_file` | `/etc/pam.d/common-session` | Generic PAM configuration file for type _session_ |
| `sudoers_config_file` | `/etc/sudoers` | Main _sudo_ configuration file |
| `sudoers_config_directory` | `/etc/sudoers.d/` | Folder with _sudo_ configuration snippets |
| `sudoers_config_snippet` | `{{ sudoers_config_directory }}{{ snippet_name }}` | The _sudo_ configuration snippet |
| `logrotate_config_file` | `/etc/logrotate.conf` | Main _logrotate_ configuration file |
| `logrotate_config_directory` | `/etc/logrotate.d` | Folder with _logrotate_ configuration snippets |
| `logrotate_config_snippet` | `{{ logrotate_config_directory }}/{{ snippet_name }}` | The _logrotate_ configuration snippet |
| `rsyslog_config_file` | `/etc/rsyslog.conf` | Main _rsyslog_ configuration file |
| `rsyslog_config_directory` | `/etc/rsyslog.d` | Folder with _rsyslog_ configuration snippets |
| `rsyslog_config_snippet` | `{{ rsyslog_config_directory }}/{{ snippet_name }}.conf` | The _rsyslog_ configuration snippet |

- _handlers/main.yaml_:

| Handler | Listen |
|:--------|:------:|
| `Reload OpenSSH Server` | `reload sshd` |
| `Restart OpenSSH Server` | `restart sshd` |
| `Restart Rsyslog service` | `restart rsyslog` |

- _vars/main.yaml_:

| Variable | Default | Description |
|:---------|:-------:|:------------|
| `snippet_name` | `{{ snippet_prefix }}-{{ ansible_role_name }}` | Name of the configuration snippets |

- _vars/debian.yaml_:

| Variable | Default | Description |
|:---------|:-------:|:------------|
| `sshd_service` | `sshd.service` | Name of the _SSHd_ service |
| `rsyslog_service` | `rsyslog.service` | Name of the _Rsyslog_ service  |

- _tasks/preflight.yaml_:

| Variable | Description |
|:---------|:------------|
| `stat_sudoers_config_file` | Whether the `{{ sudoers_config_file }}` does exist |
| `stat_logrotate_config_file` | Whether the `{{ logrotate_config_file }}` does exist |
| `stat_rsyslog_config_file` | Whether the `{{ rsyslog_config_file }}` does exist |
| `stat_sudoers_config_directory` | Whether the `{{ sudoers_config_directory }}` does exist |
| `stat_logrotate_config_directory` | Whether the `{{ logrotate_config_directory }}` does exist |
| `stat_rsyslog_config_directory` | Whether the `{{ rsyslog_config_directory }}` does exist |
