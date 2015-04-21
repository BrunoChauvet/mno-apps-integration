#!/bin/bash

# Execute commands as rpmbuilder

# Switch to project to be built
rpm_workspace=/home/rpmbuilder/rpmbuild
rm -f $rpm_workspace
ln -s /home/rpmbuilder/projects-rpm/{{application}} $rpm_workspace

# Build application from latest tag version
/home/rpmbuilder/scripts/project-build force
