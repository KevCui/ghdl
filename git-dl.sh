#!/usr/bin/env bash
#
# GitHub File Downloader
#
#/ Usage:
#/   ./git-dl.sh [-r] <url>
#/
#/ Options:
#/   <url>            GitHub URL
#/   -r               optional, recursivly download all files under each directory
#/   -h | --help      display this help message

set -e
set -u

usage() {
    printf "%b\n" "$(grep '^#/' "$0" | cut -c4-)" >&2 && exit 1
}

set_var() {
    _GITHUB_URL="https://github.com"
    _SCRIPT_PATH=$(dirname "$0")
}

set_command() {
    _CURL="$(command -v curl)" || command_not_found "curl" "https://curl.haxx.se/download.html"
    _WGET="$(command -v wget)" || command_not_found "wget" "https://ftp.gnu.org/gnu/wget/"
}

set_args() {
    expr "$*" : ".*--help" > /dev/null && usage
    _RECURSIVE_MODE=false
    while getopts ":hr" opt; do
        case $opt in
            r)
                _RECURSIVE_MODE=true
                ;;
            h)
                usage
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))
    _URL="$@"
}

print_info() {
    # $1: info message
    printf "%b\n" "\033[32m[INFO]\033[0m $1" >&2
}


print_warn() {
    # $1: warning message
    printf "%b\n" "\033[33m[WARNING]\033[0m $1" >&2
}

print_error() {
    # $1: error message
    printf "%b\n" "\033[31m[ERROR]\033[0m $1" >&2
    exit 1
}

command_not_found() {
    # $1: command name
    # $2: installation URL
    if [[ -n "${2:-}" ]]; then
        print_error "$1 command not found! Install from $2"
    else
        print_error "$1 command not found!"
    fi
}


check_var() {
    if [[ -z "${_URL:-}" ]]; then
        usage
    fi
}

get_page() {
    # $1: page URL
    $_CURL -sS "$1"
}

get_file() {
    # $1: file or directory URL
    local type path
    type=$(awk -F '/'  '{print $4}' <<< "$1")

    if [[ "$type" == "blob" ]]; then
        local pre post flink fpath upath
        pre=$(awk -F '/'  '{printf "%s/%s", $2, $3}' <<< "$1")
        post=$(awk -F '/blob/'  '{print $2}' <<< "$1")
        flink="${_GITHUB_URL}/${pre}/raw/${post}"
        fpath="$_SCRIPT_PATH/${post#*/}"
        upath="$(dirname "$(get_path_from_url "$_URL")")/"

        if [[ ! "$upath" =~ ^\. ]]; then
            path="$(dirname "$fpath" | sed -E 's:'"$upath"'::')"
        else
            path="$fpath"
        fi

        print_info "Downloading $flink"
        $_WGET -q -P "$path" "$flink"
    elif [[  "$type" == "tree" ]]; then
        if [[ "$_RECURSIVE_MODE" == true ]]; then
            path="$_SCRIPT_PATH/$(get_path_from_url "$1")"
            download_content "$_GITHUB_URL/$1" "$path"
        else
            print_info "Skip directory $1"
        fi
    else
        print_warn "Skip unknown file type $1"
    fi
}

list_content() {
    # $1: GitHub URL
    get_page "$1" \
        | grep span \
        | grep js-navigation-open \
        | grep id= \
        | sed -E 's/.*href="//' \
        | awk -F '">' '{print $1}'
}

get_path_from_url() {
    # $1: GitHub URL
    local p
    p=$(awk -F '/tree/'  '{print $2}' <<< "$1")
    echo "${p#*/}"
}

download_content(){
    # $1: GitHub URL
    local u
    for u in $(list_content "$1"); do
        get_file "$u"
    done

}

main() {
    set_args "$@"
    set_command
    set_var
    check_var
    download_content "$_URL"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
