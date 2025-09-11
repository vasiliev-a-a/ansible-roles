# Examples

___

```yaml
---
- name: "Initialize common variables"
  hosts: all
  roles:
    - role: common_variables
  tasks:
  - debug:
      msg:
      - "origin_label: {{ origin_label | default('undefined') }}"
      - "origin_prefix: {{ origin_prefix | default('undefined') }}"
      - "origin: {{ origin | default('undefined') }}"
      - "pam_common_session_file: {{ pam_common_session_file | default('undefined') }}"
      - "system_logrotate_config_file: {{ system_logrotate_config_file | default('undefined') }}"
      - "_system_logrotate_config_file: {{ _system_logrotate_config_file | default('undefined') }}"
      - "system_logrotate_config_directory: {{ system_logrotate_config_directory | default('undefined') }}"
      - "_system_logrotate_config_directory: {{ _system_logrotate_config_directory | default('undefined') }}"
      - "rsyslog_service_name: {{ rsyslog_service_name | default('undefined') }}"
      - "system_rsyslog_config_file: {{ system_rsyslog_config_file | default('undefined') }}"
      - "_system_rsyslog_config_file: {{ _system_rsyslog_config_file | default('undefined') }}"
      - "system_rsyslog_config_directory: {{ system_rsyslog_config_directory | default('undefined') }}"
      - "_system_rsyslog_config_directory: {{ _system_rsyslog_config_directory | default('undefined') }}"
      - "sshd_service_name: {{ sshd_service_name | default('undefined') }}"
      - "system_sshd_config_file: {{ system_sshd_config_file | default('undefined') }}"
      - "system_sudoers_config_file: {{ system_sudoers_config_file | default('undefined') }}"
      - "_system_sudoers_config_file: {{ _system_sudoers_config_file | default('undefined') }}"
...
```

___
