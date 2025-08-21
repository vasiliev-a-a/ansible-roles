# Examples

___

```yaml
---
- name: "Deploy Zabbix Agent"
  hosts: all
  roles:
    - role: zabbix-agent
      zabbix_agent_remote_commands: true
      zabbix_agent_option_server: "192.168.0.100"
      zabbix_agent_sudoers_cmnd_list:
        - "/usr/bin/false"
        - "/usr/bin/true"
...
```

___
