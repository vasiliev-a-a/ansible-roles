# Role `zabbix-agent`

This role installs and configures Zabbix Agent.

☝️**Important:** If `zabbix_agent_remote_commands` is enabled,  
then `zabbix_agent_user` is allowed to _sudo_ with no password prompt.

## Limitations

- Only Debian-based OS support is implementend at the moment.

## Role Variables

- _defaults/main.yaml_:

- `zabbix_agent_pid_file` - path to the agent's PID file.
- `zabbix_agent_log_file` -  path to the agent's log file.
- `zabbix_agent_config_root` - root folder for configuration components.
- `zabbix_agent_config_file` - the main configuration file.
- `zabbix_agent_config_directory` - directory for drop-in configuration snippets.
- `zabbix_agent_config_snippet` - configuration snippet that will be created.
- `zabbix_agent_debug_level` - logging verbosity.
- `zabbix_agent_server` -  address of the Zabbix Server.
- `zabbix_agent_server_active` -  address of the Active Zabbix Server.
- `zabbix_agent_remote_commands` -  whether remote commands should be enabled.
- `zabbix_agent_refresh_active_checks` -  how frequently refresh configuration from `zabbix_agent_server_active`.
- `zabbix_agent_hostname` -  hostname that is passed by _zabbix-agent_ to the configured servers.
- `zabbix_agent_user` -  name of the user that will run _zabbix-agent_.
- `zabbix_agent_group` -  group of the user that will run _zabbix-agent_.
- `zabbix_agent_config_extra` - if defined, will be included at the end of `zabbix_agent_config_snippet` as is.

- _vars/debian.yaml_:

- `packages_install` - list of packages that this role will install.
- `zabbix_agent_service` - identity of the _zabbix-agent_ service.

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
