#! /bin/bash

game_support_dir="../../src/game-support"

function verify_game_title_from_steam {
    game_file="$1"
    generic_app_url="https://store.steampowered.com/app"

    whisky_app_id_raw=$(grep "id=" "$game_file")
    whisky_app_id_trimmed_front=${whisky_app_id_raw#\{\{#template ../templates/steam.md id=}

    whisky_app_id=${whisky_app_id_trimmed_front%\}\}}
    echo "Whisky App ID: $whisky_app_id"

    wget "${generic_app_url}/${app_id}/"

    steam_title_raw=$(grep "<title>" "index.html" | xargs)
    steam_title_trimmed_front=${title_raw#<title>}

    steam_title=${title_trimmed_front% on Steam</title>}
    echo "Steam Title: $steam_title"

    whisky_title_raw=$(head -n 1 $game_file)
    whisky_title=${whisky_title_raw# #}

    echo "Whisky Title: $whisky_title"

    rm -f "index.html"
}

for game_file in $(ls $game_support_dir); do
    echo "HELLO $game_file"
    verify_game_title_from_steam "$game_support_dir/$game_file"
done
