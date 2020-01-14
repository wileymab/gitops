#!/usr/bin/env bash
# dependecies { curl }


GITHUB_API_URL=https://github.8451.com/api/v3
GITHUB_TOKEN=2d8c40567f93d92141dd4efaf2efec88322f5d2a

function repo {
    case "${1}" in
        "create")
            shift
            curl -X POST -H "Authorization: token ${GITHUB_TOKEN}" "${GITHUB_API_URL}/user/repos" -d "{ \"name\": \"${1}\" }"
            ;;
        *)
            # TODO "repo" command usage here
            echo '"repo" command usage here'
            ;;
    esac
}


function gitops {
    case "${1}" in
        "repo")
            shift
            repo $@
            ;;
        *)
            # TODO "gitops" command usage here
            echo '"gitops" command usage here'
            ;;
    esac
}


gitops $@


# curl -X POST -H "Authorization: token ${GITHUB_TOKEN}" "${GITHUB_API_URL}/user/repos" -d "{ \"name\": \"${1}\" }"