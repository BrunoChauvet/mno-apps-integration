#!/bin/bash

# Execute commands as RPM Builder user
su rpmbuilder
cd /home/rpmbuilder

# Switch to project to be built
rpm_workspace=/home/rpmbuilder/rpmbuild
rm -f $rpm_workspace
ln -s {{ project_name }} $rpm_workspace

# Build application from latest tag version
project-build force
