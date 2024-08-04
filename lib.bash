declare -A URL

url_parse() {
    local pattern='^(([^:/?#]+):)?(//((([^:/?#]+)@)?([^:/?#]+)(:([0-9]+))?))?(/([^?#]*))?(\?([^#]*))?(#(.*))?'
    [[ "$1" =~ $pattern ]] && [ "${BASH_REMATCH[2]}" ] && [ "${BASH_REMATCH[4]}" ] || return 1
    URL=(
        [proto]=${BASH_REMATCH[2]}
        [host]=${BASH_REMATCH[4]}
        [hostname]=${BASH_REMATCH[7]}
        [port]=${BASH_REMATCH[9]}
        [pathname]=${BASH_REMATCH[10]:-/}
        [search]=${BASH_REMATCH[12]}
        [hash]=${BASH_REMATCH[14]}
    )
}

fetch() { curl -sfL --connect-timeout 3 -m 3 -A 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36' -H 'accept-language: en-US,en;q=0.9' -H 'upgrade-insecure-requests: 1' "$@"; }

is_html() { fetch -I "$1" | grep -Ei '^content-type:\s+text/html' > /dev/null; }

search() { grep -Fx -- "$1" "$2" > /dev/null; }
