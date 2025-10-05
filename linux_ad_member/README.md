# Examples

___

## Prompt for credentials

```yaml
---
- name: "Join computers to domain"
  hosts: linux:&domain
  vars_prompt:
  - name: ad_member_join_user
    prompt: "Provide username (without the domain part) with permissions to join computer to domain"
    private: no
  - name: ad_member_join_pass
    prompt: "Provide password for the specified username"
  roles:
  - role: linux_ad_member
    sssd_allow_groups: ["linux_administrators"]
...
```

___
