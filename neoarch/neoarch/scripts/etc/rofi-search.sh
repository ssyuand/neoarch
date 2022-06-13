#!/usr/bin/env bash
declare -A URLS

URLS=(
  ["url"]="https://"
  ["translate"]="https://translate.google.com.tw/?q="
  ["google"]="https://www.google.com/search?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["github"]="https://github.com/"
  ["stackoverflow"]="http://stackoverflow.com/search?q="
  ["math"]="https://www.mathway.com/zh/Algebra?asciimath="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search > " )

  if [[ -n "$platform" ]]; then
    query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0

