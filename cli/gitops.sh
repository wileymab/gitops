#!/usr/bin/env bash
function main {
    local scriptDir=$(dirname ${BASH_SOURCE[0]})
    source ${scriptDir}/modules/logger.sh
    source ${scriptDir}/modules/api-utils.sh
    source ${scriptDir}/modules/gitops-repos.sh

    opts="$*"
    log INFO " >> ${opts}"
    case "${1}" in
        "repos") shift; gitops.repos $@ ;;
        # ".curl")
        #     shift
        #     apiCall GET users/wileymab
        #     ;;
        *)
            # TODO "gitops" command usage here
            echo '"gitops" command usage here'
            ;;
    esac
}

main $@