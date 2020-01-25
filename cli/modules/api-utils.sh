function apiCall {

    local HEADER_ACCEPT="Accept: application/vnd.github.v3+json"
    local HEADER_AUTHORIZATION="Authorization: token ${GITHUB_TOKEN}"
    local HEADER_NO_CACHE="Cache-Control: no-cache"

    if [[ -n "${3}" ]]; then
        curl -sSL \
            -H  "${HEADER_ACCEPT}" \
            -H  "${HEADER_AUTHORIZATION}" \
            -X "${1}" \
            "${GITHUB_API_URL}/${2}" -d "${3}"
    else 
        curl -sSL \
            -H  "${HEADER_ACCEPT}" \
            -H  "${HEADER_AUTHORIZATION}" \
            -X "${1}" \
            "${GITHUB_API_URL}/${2}"
    fi

}