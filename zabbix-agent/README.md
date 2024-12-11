# Role `zabbix-agent`

This role installs and configures Zabbix Agent.

☝️**Important:** If `zabbix_agent_remote_commands` is enabled, then `zabbix_agent_user` is allowed to **sudo** commands listed in the `{{ zabbix_agent_sudo_tools }}` with no password prompt.

___

## Limitations

- Only Debian-based OS support is implementend at the moment.

___

## Dependencies

- `defaults` - to import common variables and handlers.

___

## Role Content

Package manager repository is configured in one of two ways:

1. If `zabbix_agent_repo` is defined, then it will be used to setup cofiguration file
2. Template for supported package manager is used to generate configuration file using the Official Zabbix repository, ansible host facts, and desired version

- _defaults/main.yaml_:

  | Variable | Default | Description |
  |:--------:|:-------:|:------------|
  | `apt_trusted_gpg_d` | `/etc/apt/trusted.gpg.d` | APT GPG keys drop-in configuration directory. |
  | `apt_sources_list_d`| `/etc/apt/sources.list.d` | APT repositories drop-in configuration directory. |
  | `zabbix_agent_config_directory` | `{{ zabbix_agent_config_root }}/zabbix_agentd.conf.d` | **zabbix-agent** drop-in configuration directory. |
  | `zabbix_agent_config_extra` |  | If defined, will be included at the end of `zabbix_agent_config_snippet` as is. |
  | `zabbix_agent_config_file` | `{{ zabbix_agent_config_root }}/zabbix_agentd.conf` | **zabbix-agent** main configuration file. |
  | `zabbix_agent_config_root` | `/etc/zabbix` | Zabbix components configuration directory. |
  | `zabbix_agent_config_snippet` | `{{ zabbix_agent_config_directory }}/{{ snippet_name }}.conf` | **zabbix-agent** configuration snippet. |
  | `zabbix_agent_debug_level` | `3` | Logging verbosity. |
  | `zabbix_agent_group` | `{{ zabbix_agent_user }}` | Group of the user that will run **zabbix-agent**. |
  | `zabbix_agent_hostname` | `{{ ansible_facts['hostname'] \| upper }}` | Hostname that is passed by **zabbix-agent** to the configured servers. |
  | `zabbix_agent_log_file` | `/var/log/zabbix/zabbix_agentd.log` | **zabbix-agent** log file. |
  | `zabbix_agent_log_remote_commands` | `0` | Whether remote commands should be logged. |
  | `zabbix_agent_logrotate_config_snippet` | `{{ logrotate_config_directory }}/zabbix-agent` | **logrotate** configuration snippet. |
  | `zabbix_agent_pid_file` | `/var/run/zabbix/zabbix_agentd.pid` | **zabbix-agent** PID file. |
  | `zabbix_agent_refresh_active_checks` | `300` | How frequently refresh configuration from `zabbix_agent_server_active`. |
  | `zabbix_agent_remote_commands` | `false` | Whether remote commands should be enabled. |
  | `zabbix_agent_server` | `127.0.0.1` | Address of the Zabbix Server. |
  | `zabbix_agent_server_active` | `{{ zabbix_agent_server }}` | Address of the Active Zabbix Server. |
  | `zabbix_agent_sudoers_config_snippet` | `{{ sudoers_config_snippet }}` | **sudo** configuration snippet. |
  | `zabbix_agent_user` | `zabbix` | Name of the user that will run **zabbix-agent**. |
  | `zabbix_agent_version` | `6.0` | Version of the **zabbix-agent** to install. |
  | `zabbix_agent_sudo_tools` | `["/usr/bin/false"]` | Commands that **zabbix-agent** is allowed to **sudo**. |

- _vars/debian.yaml_:

  | Variable | Default | Description |
  |:--------:|:-------:|:------------|
  | `packages_install` | `[zabbix-agent]` | List of packages that this role will install. |
  | `zabbix_agent_service` | `zabbix-agent.service` | Identity of the **zabbix-agent** service. |

___

## Example Playbook

```yaml
---
- name: "Deploy Zabbix Agent"
  hosts: linux
  roles:
    - role: zabbix-agent
      zabbix_agent_remote_commands: true
      zabbix_agent_server: "192.168.0.100"
...
```

___
