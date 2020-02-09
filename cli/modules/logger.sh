function log {
    local scriptDir=$(dirname ${BASH_SOURCE[0]})

    timestamp=$(date "+[%Y-%m-%d %H:%M:%S]")
    classification=${1}
    message=${2}
    printf "${timestamp}\t${classification}\t${message}\n" >> "$scriptDir/../../gitops.csv"
}