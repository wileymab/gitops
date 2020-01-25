#!/usr/bin/env bash
scriptDir=$(dirname ${BASH_SOURCE[0]})

source ${scriptDir}/modules/gitops-repos.sh

function main {
    case "${1}" in
        "repos")
            shift; gitops.repos $@
            ;;
        *)
            # TODO "gitops" command usage here
            echo '"gitops" command usage here'
            ;;
    esac
}

main $@