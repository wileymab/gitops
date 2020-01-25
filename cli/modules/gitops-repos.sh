scriptDir=$(dirname ${BASH_SOURCE[0]})
source ${scriptDir}/api-utils.sh

function _create {
    apiCall POST user/repos "{\"name\":\"${1}\"}"
}

function _get {
    # mine
    # user's public
    # org public
    # all public
    case "${1}" in  
        "mine")
            apiCall GET user/repos
            ;;
        *)  
            found_login=$(apiCall GET "users/${1}" | jq -r .login || "")
            if [[ "${found_login}" == "${1}" ]]; then 
                apiCall GET "users/${1}/repos" | jq -r "${2}"
            else
                echo "User not found"
            fi
            ;;
    esac
}

function gitops.repos {
    case "${1}" in
        "get-mine") shift; _get mine $@;;
        "user") shift; _get $@;;
        "new") shift; _create $@;;
        *)
            # TODO "repo" command usage here
            echo '"repo" command usage here'
            ;;
    esac
}