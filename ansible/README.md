# Use Ansible to automate some tasks

## Busy developer guide

The `inventory` file contains the list of hosts to execute ssh commands against
Ping your inventory using
`ansible all -m ping -i inventory`

## Recreate an application tag
ansible-playbook -i inventory playbooks/tag-app.yml

## Build RPM package
ansible-playbook -i inventory playbooks/build-application-rpm.yml --extra-vars="application=vtigercrm-6.2.0"

## Fix RPM package permissions
ansible-playbook -i inventory playbooks/publish-application-rpm.yml --extra-vars="application=vtigercrm-6.2.0"