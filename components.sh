#!/bin/bash

if [ $# -lt 1 ];
then
   echo "Usage: $0 <project_directory> <ComponentName1> [ComponentName2] ..."
   exit 1
fi

project_directory=$1
shift
for component_name in "$@"; do
   count=$(grep -roh "\<${component_name}\>" "$project_directory" | wc -l)
   echo "${component_name} is used ${count} times"
done