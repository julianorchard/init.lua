#!/usr/bin/env ansible-playbook
---
- name:
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role:
      # async: 3600
      # poll: 0

# vi: ft=yaml
