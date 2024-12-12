# Role `defaults`

The sole purpose of this role is to hold various frequently used variables and handlers.

It can be either included as a dependency, or assigned explicitly within a playbook.

>✍️**Note:** Although there is a lot of variables, only one action is performed - enforcing the drop-in configuration model for the **sudo**. All other usecases of variables are left to specialized roles.

___

## Limitations

- Only Debian-based OS support is implementend at the moment.

___

## Role Content

- _defaults/main.yaml_:

  If optional `snippet_prefix` is defined, then it will be prepended to every config snippet until `*_config_snippet` is explicitly defined.

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `logrotate_config_directory` | `/etc/logrotate.d` | **logrotate** drop-in configuration directory. |
  | `logrotate_config_file` | `/etc/logrotate.conf` | **logrotate** main configuration file. |
  | `logrotate_config_snippet` | `{{ logrotate_config_directory }}/{{ snippet_name }}` | **logrotate** configuration snippet. |
  | `pam_common_session_file` | `/etc/pam.d/common-session` | PAM configuration file for common session tasks. |
  | `rsyslog_config_directory` | `/etc/rsyslog.d` | **rsyslog** drop-in configuration directory. |
  | `rsyslog_config_file` | `/etc/rsyslog.conf` | **rsyslog** main configuration file. |
  | `rsyslog_config_snippet` | `{{ rsyslog_config_directory }}/{{ snippet_name }}.conf` | **rsyslog** configuration snippet. |
  | `snippet_name` | `{{ ansible_role_name }}` | Name for configuration snippets. |
  | `sshd_config_file` | `/etc/ssh/sshd_config` | **sshd** main configuration file. |
  | `sudoers_config_directory` | `/etc/sudoers.d/` | **sudo** drop-in configuration directory. |
  | `sudoers_config_file` | `/etc/sudoers` | **sudo** main configuration file. |
  | `sudoers_config_snippet` | `{{ sudoers_config_directory }}{{ snippet_name }}` | **sudo** configuration snippet. |

- _handlers/main.yaml_:

  | Handler | Listen |
  |:--------|:------:|
  | `Reload OpenSSH Server` | `reload sshd` |
  | `Restart OpenSSH Server` | `restart sshd` |
  | `Restart Rsyslog service` | `restart rsyslog` |

- _vars/debian.yaml_:

  | Variable | Default | Description |
  |:---------|:-------:|:------------|
  | `rsyslog_service` | `rsyslog.service` | Identity of the **rsyslog** service. |
  | `sshd_service` | `sshd.service` | Identity of the **sshd** service. |

- _tasks/preflight.yaml_:

  | Variable | Description |
  |:---------|:------------|
  | `stat_logrotate_config_directory` | Whether the `{{ logrotate_config_directory }}` does exist. |
  | `stat_logrotate_config_file` | Whether the `{{ logrotate_config_file }}` does exist. |
  | `stat_rsyslog_config_directory` | Whether the `{{ rsyslog_config_directory }}` does exist. |
  | `stat_rsyslog_config_file` | Whether the `{{ rsyslog_config_file }}` does exist. |
  | `stat_sudoers_config_directory` | Whether the `{{ sudoers_config_directory }}` does exist. |
  | `stat_sudoers_config_file` | Whether the `{{ sudoers_config_file }}` does exist. |

___
