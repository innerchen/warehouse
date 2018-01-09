#!/usr/bin/env bash

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME=monokai
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG=monokai
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
    {
        "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
        echo "'$val'"
    } | head -c-1 | tr "\n" ,
    )"

    "$DCONF" write "$key" "[$entries]"
}

# Newest versions of gnome-terminal use dconf
if which "$DCONF" > /dev/null 2>&1; then
    [[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

    if [[ -n "`$DCONF list $BASE_KEY_NEW/`" ]]; then
        if which "$UUIDGEN" > /dev/null 2>&1; then
            PROFILE_SLUG=`uuidgen`
        fi

        if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
            DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
        else
            DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
        fi

        for EXIST_PROFILE in `$DCONF list $BASE_KEY_NEW/ | grep '^:' | tr -d :/`; do
            if $DCONF dump "$BASE_KEY_NEW/:$EXIST_PROFILE/" | grep "'$PROFILE_NAME'" >/dev/null; then
                exit 0
            fi
        done

        DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
        PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

        # copy existing settings from default profile
        $DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

        # add new copy to list of profiles
        dlist_append $BASE_KEY_NEW/list "$PROFILE_SLUG"

        # update profile values with theme options
        dset visible-name "'$PROFILE_NAME'"
        dset palette "['rgb(39,40,34)','rgb(249,42,114)','rgb(166,226,46)','rgb(230,219,116)','rgb(80,186,250)','rgb(174,129,255)','rgb(102,217,239)','rgb(117,113,94)','rgb(73,72,62)','rgb(245,66,53)','rgb(189,240,63)','rgb(253,151,31)','rgb(136,207,255)','rgb(201,180,255)','rgb(112,247,255)','rgb(255,255,255)']"
        dset background-color "'rgb(39,40,34)'"
        dset foreground-color "'rgb(248,248,242)'"
        dset bold-color "'rgb(248,248,242)'"
        dset bold-color-same-as-fg "false"
        dset use-theme-colors "false"

        unset PROFILE_NAME
        unset PROFILE_SLUG
        unset DCONF
        unset UUIDGEN
        exit 0
    fi
fi

