#!/usr/bin/env bash
# dependecies { curl }

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