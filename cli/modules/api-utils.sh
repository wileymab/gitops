function apiCall {
    local scriptDir=$(dirname ${BASH_SOURCE[0]})
    source ${scriptDir}/logger.sh
    
    local HEADER_ACCEPT="Accept: application/vnd.github.v3+json"
    local HEADER_AUTHORIZATION="Authorization: token ${GITHUB_TOKEN}"
    local HEADER_NO_CACHE="Cache-Control: no-cache"

    split() {
        IFS="${1}"
        read -ra ADDR <<< "$@"
        for i in "${ADDR[@]}"; do
            echo $i
        done
    }

    build_json_body() {
        # private:bool=true;affiliation:str=owner,collaborator,organization_member;team_id:int=3201
        json="{"
        param_defns=($(split ';' "${1}"))
        defn_count=${#a[@]}
        index=0
        for param_defn in ${param_defns[@]}; do

            nametype_and_value=($(split '=' ${param_defn}))
            value=${nametype_and_value[1]}
            name_and_type=($(split ':' ${nametype_and_value[0]}))
            name=${name_and_type[0]}
            type=${name_and_type[1]}

            case "${type}" in
                "int":"bool")
                    json="${json}\"${name}\":${value}"
                    ;;
                "str")
                    json="${json}\"${name}\":\"${value}\""
                    ;;
            esac

            if [[ $indec < $defn_count ]]; then
                json="${json},"
            fi

            index=$index+1
        done
        json="${json}}"
    }

    build_query_params() {
        # private:bool=true;affiliation:str=owner,collaborator,organization_member;team_id:int=3201
        : # TODO implement build_query_params
        query_string=""
        if [[ -n "${1}" ]]; then
            query_string="?$(echo "${1}" | sed 's/:[strinbol]*=/=/g' | sed 's/;/\&/g')"
            log INFO "${1} --> ${query_string}"
        fi
        echo ${query_string}
    }

    cmd=(
        curl -isSL
        -H "\"${HEADER_ACCEPT}\""
        -H "\"${HEADER_AUTHORIZATION}\""
        -X "${1}"
    )

    case "${1}" in 
        "GET")
            query_string=$(build_query_params ${3})
            cmd+=("${GITHUB_API_URL}/${2}${query_string}")
            ;;
        "POST","PUT")
            payload=$(build_json_body ${3})
            cmd+=("${GITHUB_API_URL}/${2}" "-d" "${payload}")
            ;;
        *)
            : # Default to ignoring the data
            ;;
    esac

    request="${cmd[@]}"
    response=$(bash -c "${request}")

    status=$(echo "${response}" | head -n1 | grep -o -e "\b[0-9][0-9][0-9]\b")
    body=$(echo "${response}" | grep -v -e "^[a-zA-Z]" -e "^$")
    
    if [[ ${status} == 200 ]]; then
        log INFO "${status} ${request}"
        echo ${body}
    else
        error_message=$(echo ${body} | jq -r .message)
        log ERROR "${status} ${request}"
        log ERROR "${status} ${error_message}"
        echo ${error_message}
    fi

}