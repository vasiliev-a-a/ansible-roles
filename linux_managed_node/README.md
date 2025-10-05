# Examples

___

## Credentials in the playbook

```yaml
---
- name: "Prepare new nodes to be managed by Ansible"
  hosts: newcommers
  vars:  # Consider putting these somewhere into inventory, or passing them with `-e` flags.
    ansible_user: "<UserToConnectWith>"
    ansible_password: "<PasswordToConnectWith>"
  roles:
    - role: linux_managed_node
      ansible_controller_addresses:
      - "172.16.1.10"
      - "host.323.pri"
      ansible_account_authorized_keys_extra:
      - "<boss_key>"
      - "<my_key>"
      - "<team_key>"
...
```

___

## Prompt for credentials

```yaml
---
- name: "Prepare new nodes to be managed by Ansible"
  hosts: newcommers
  vars_prompt:
  - name: ansible_user
    prompt: "User with sudo capabilities on target hosts"
    private: no
  - name: ansible_password
    prompt: "Password for the specified username"
  roles:
    - role: linux_managed_node
      ansible_controller_addresses:
      - "172.16.1.10"
      - "host.323.pri"
      ansible_account_authorized_keys_extra:
      - "<boss_key>"
      - "<my_key>"
      - "<team_key>"
...
```

___
