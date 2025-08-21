# Examples

___

## Prompt for credentials

```yaml
---
- name: "Join computers to domain"
  hosts: linux:&domain
  vars_prompt:
  - name: addomain_join_user
    prompt: "Provide username (without the domain part) with permissions to join computer to domain"
    private: no
  - name: addomain_join_pass
    prompt: "Provide password for the specified username"
  roles:
  - role: addomain
    sssd_allow_groups: ["linux_administrators"]
...
```

___
