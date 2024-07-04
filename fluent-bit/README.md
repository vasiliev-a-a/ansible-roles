# Role `fluent-bit`

This role installs and configures Fluent Bit telemetry agent.

The simplest approach were taken to build the configuration:

- Whole sections must be provided in corresponding variables `fluent_bit_config_[env|includes|service|inputs|filters|outputs]`
- Variables then merged into the configuration file by means of `config.j2` template
- If hosts or groups require different configurations, then `./host_vars/` or `./group_vars/` direcotries, or inventory variables can be used to re-define required parts of configuration

## Limitations

- Only Debian-based OS support is implementend at the moment.

## Role Variables

- _defaults/main.yaml_:

  - `fluent_bit_version` - version of the _fluent-bit_ to install
  - `fluent_bit_bin_file` - absolute path to where binary is installed on the concrete distribution
  - `fluent_bit_config_directory` - absolute path to the root configuration directory
  - `fluent_bit_config_file` - main _fluent-bit_ service configuration file
  - `fluent_bit_lua_filters_file` - file with defined LUA functions used in filters/processors
  - `fluent_bit_systemd_unit_file` - absolute path to where customized systemd `.service` file will be created
  - `fluent_bit_config_env` - content of `env:` section of the configuration
  - `fluent_bit_config_includes` - content of `includes:` section of the configuration
  - `fluent_bit_config_service` - content of `service:` section of the configuration
  - `fluent_bit_config_inputs` - content of `pipeline.inputs:` section of the configuration
  - `fluent_bit_config_filters` - content of `pipeline.filters:` section of the configuration
  - `fluent_bit_config_outputs` - content of `pipeline.outputs:` section of the configuration

  ✍️**Note:** Read the [official documentation](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/yaml/configuration-file) for YAML configuration format.

- _vars/debian.yaml_:

  - `packages_install` - list of packages that this role will install.
  - `fluent_bit_service` - identity of the _fluent-bit_ service.

## Example Playbook

```yaml
---
- name: "Deploy FluentBit agent"
  hosts: linux
  roles:
    - role: fluent-bit
      fluent_bit_config_outputs: |
        - name: "loki"
          match: "logs.*"
          retry_limit: 30
          host: "loki.svc.domain.local"
          port: 3100
          tenant_id: "ZQqp5Gxb6Icy9TMk"
          label_keys: "${loki_labels}"
          remove_keys: "${loki_labels}"
          line_format: "key_value"
...
```
