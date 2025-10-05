# Examples

___

```yaml
---
- name: "Deploy FTP servers"
  hosts: ftp-srv-01,ftp-srv-02
  serial: 1
  max_fail_percentage: 49
  roles:
    - role: linux_vsftpd_server
      ftp_users:
        - name: user
          id: 2001
          password: test
          role: user
        - name: superuser
          id: 2002
          password: supertest
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
