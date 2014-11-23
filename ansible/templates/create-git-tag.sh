#!/bin/bash

# Recreate the last Git tag for current project
# - checkout the branch you want to tag from
# - run script from project home directory

# Get last project tag
latest_tag=( `git tag -l | tail -n 1` )
echo "Recreating tag $latest_tag"

# Delete tag
echo "Executing: git tag -d $latest_tag"
git tag -d $latest_tag

# Push to repository
echo "Executing: git push origin :refs/tags/$latest_tag"
git push origin :refs/tags/$latest_tag

# Recreate tag
echo "Executing: git tag -a $latest_tag -m $latest_tag"
git tag -a $latest_tag -m $latest_tag

# Push new tag to repository
echo "Executing: git push --tags"
git push --tags
