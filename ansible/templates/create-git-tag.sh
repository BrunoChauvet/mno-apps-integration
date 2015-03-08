#!/bin/bash

# Recreate the last Git tag for current project
# - checkout the branch you want to tag from
# - run script from project home directory

if [ "$#" -ne 1 ]; then
  # No tag specified, get the last project tag
  latest_tag=( `git tag -l | tail -n 1` )
else
  # Check if we are creatign a new tag or overwritting an existing one
  latest_tag=$1
  all_tags=( $( git tag -l ) )

  if [[ " ${all_tags[*]} " == *" ${latest_tag} "* ]]; then
    echo "Recreating tag ${latest_tag}"
  else
    echo "Creating a new tag"
  fi
fi

remote='origin'

# Delete tag
echo "Executing: git tag -d $latest_tag"
git tag -d $latest_tag

# Push to repository
echo "Executing: git push ${remote} :refs/tags/$latest_tag"
git push ${remote} :refs/tags/$latest_tag

# Recreate tag
echo "Executing: git tag -a $latest_tag -m $latest_tag"
git tag -a $latest_tag -m $latest_tag

# Push new tag to repository
echo "Executing: git push --tags"
git push --tags ${remote}
