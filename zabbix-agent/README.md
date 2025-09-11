# Examples

___

```yaml
---
- name: "Setup package manager repositories"
  hosts: all
  tasks:
  - name: "Setup APT repositories"
    block:
    - ansible.builtin.copy:
        backup: true
        src: "{{ item }}"
        dest: "/etc/apt/trusted.gpg.d/{{ item.split('/')[-1] }}"
        mode: 0644
      with_fileglob: "files/etc_apt_trusted.gpg.d/*"
    - ansible.builtin.copy:
        dest: "/etc/apt/sources.list.d/zabbix-6.4-stable.list"
        content: "deb https://repo.zabbix.com/zabbix/6.4/{{ ansible_distribution | lower }} {{ ansible_distribution_release | lower }} main"
        backup: true
        mode: 0644
        validate: "/usr/bin/apt-get -o dir::etc::sourceparts=/dev/null -o dir::etc::sourcelist=%s update"
      ignore_errors: true
    - ansible.builtin.copy:
        dest: "/etc/apt/sources.list.d/zabbix-7.0-stable.list"
        content: "deb https://repo.zabbix.com/zabbix/7.0/{{ ansible_distribution | lower }} {{ ansible_distribution_release | lower }} main"
        backup: true
        mode: 0644
        validate: "/usr/bin/apt-get -o dir::etc::sourceparts=/dev/null -o dir::etc::sourcelist=%s update"
      ignore_errors: true
    - ansible.builtin.copy:
        dest: "/etc/apt/sources.list.d/zabbix-7.4-stable.list"
        content: "deb https://repo.zabbix.com/zabbix/7.4/stable/{{ ansible_distribution | lower }} {{ ansible_distribution_release | lower }} main"
        backup: true
        mode: 0644
        validate: "/usr/bin/apt-get -o dir::etc::sourceparts=/dev/null -o dir::etc::sourcelist=%s update"
      ignore_errors: true
    - ansible.builtin.apt:
        autoclean: true
        update_cache: true
        update_cache_retries: 2
        update_cache_retry_max_delay: 5
    become: true
    when: (ansible_pkg_mgr | lower) == 'apt'
...
```

___

```yaml
---
- name: "Deploy Zabbix Agent"
  hosts: all
  roles:
    - role: zabbix-agent
      zabbix_agent_role_config_extra: |
        Server=1.1.1.1
        RefreshActiveChecks=0
        Hostname={{ ansible_facts['hostname'] | upper }}
      zabbix_agent_sudoers_cmnd_list:
        - "/usr/bin/false"
        - "/usr/bin/true"
...
```

___
