function _init {
    local scriptDir=$(dirname ${BASH_SOURCE[0]})
    source ${scriptDir}/api-utils.sh
}
_init

function _create {
    apiCall POST user/repos "{\"name\":\"${1}\"}"
}

function _list {
    case "${1}" in
        "mine")
            # Lists repositories that the authenticated user has explicit permission (:read, :write, or :admin) to access.
            # GET /user/repos
            shift
            params=($(echo "$@" | sed 's/ /;/g'))
            apiCall GET user/repos ${params[@]}
            ;;
        "user")
            # Lists public repositories for the specified user.
            # GET /users/:username/repos
            username="${2}"
            shift 2
            params=($(echo "$@" | sed 's/ /;/g'))
            apiCall GET "users/${username}/repos" ${params[@]}
            ;;
        "org")
            # Lists repositories for the specified organization.
            # GET /orgs/:org/repos
            org="${2}"
            shift 2;
            params=($(echo "$@" | sed 's/ /;/g'))
            apiCall GET "orgs/${org}/repos" ${params[@]}
            ;;
        "all")
            # TODO Should the "list all" option even be provided?
            # Lists all public repositories in the order that they were created.
            # GET /repositories
            apiCall GET "repositories"
            ;;
    esac
}

function gitops.repos {
    case "${1}" in
        "list") shift; _list $@;;
        "new") shift; _create $@;;
        *)
            # TODO "repo" command usage here
            echo '"repo" command usage here'
            ;;
    esac
}