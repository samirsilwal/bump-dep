#!/bin/bash

# Check if enough arguments were passed
if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <monorepo-root-directory> <dependency-name> <new-version>"
  exit 1
fi

# Arguments
monorepo_root=$1
dependency_name=$2
new_version=$3

# Find package.json files in the root of each microservice, excluding node_modules and nested directories
find "$monorepo_root" -mindepth 2 -maxdepth 2 -type f -name "package.json" -not -path "*/node_modules/*" | while read -r package_json; do
  echo "Updating $dependency_name to version $new_version in $package_json"

  # Update the dependency version using jq
  jq --arg dep "$dependency_name" --arg ver "$new_version" \
    'if .dependencies[$dep] then .dependencies[$dep] = $ver 
     elif .devDependencies[$dep] then .devDependencies[$dep] = $ver 
     else . end' "$package_json" > tmp.json && mv tmp.json "$package_json"
done


cd $monorepo_root 

for d in */ ; do
    echo "Updating packages in $d"
    
    cd $d

    yarn 
    
    echo "Completed Updating packages in $d"

    cd ..
done
