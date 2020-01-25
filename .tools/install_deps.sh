#!/usr/bin/env bash
scriptDir=$(dirname ${BASH_SOURCE[0]})

# deps=""
for dep in $(cat "${scriptDir}/../deps.txt"); do 
    # deps=deps+"${line} "
    brew install ${dep}
done

# sudo apt-get install -y ${deps}