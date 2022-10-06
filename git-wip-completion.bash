#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright 2017, Mattias Bengtsson <mattias.jc.bengtsson@gmail.com>

_git_local () {
    _git_wip "${@}"
}

_git_wip () {
    local subcommands subcommand
    subcommands="autosquash fixup for-all log reapply rebase-point squash"
    subcommand="$(__git_find_on_cmdline "$subcommands")"

    if [ -z "$subcommand" ]; then
	__gitcomp "$subcommands"
	return
    fi

    case "$subcommand" in
        autosquash)	  _git_wip_rebase    ;;
        fixup)	          _git_commit        ;;
        for-all)	  _git_wip_for-all   ;;
        log)              _git_wip_log       ;;
        reapply)          _git_wip_rebase    ;;
        rebase-point)     COMPREPLY=()       ;;
        squash)           _git_commit        ;;
        *)                COMPREPLY=()       ;;
    esac
}

# I have yet to find out how to make bash completion not fallback to file
# completion when returning an empty COMPREPLY.
# As a workaround return a COMPREPLY with one element: the empty string and
# echo the bel character.
__no_file_fallback () {
    echo -en "\a"
    COMPREPLY=( '' )
}


# shellcheck disable=SC2154
_git_wip_rebase () {
    case "$cur" in
        --*)  _git_rebase         ;;
        *)    __no_file_fallback  ;;
    esac
}

# shellcheck disable=SC2154
_git_wip_log () {
    case "$cur" in
        --*)  _git_log            ;;
        *)    __no_file_fallback  ;;
    esac
}

# shellcheck disable=SC2154
_git_wip_for-all () {
    local forall_offset cmd_offset

    # Find the 'for-all' word
    for (( i=1; i <= cword; i++ )); do
        if [ "${words[i]}" = "for-all" ]; then
            forall_offset=$((i))
            break
        fi
    done

    # Find the command
    for (( i=forall_offset; i <= cword; i++ )); do
        case ${words[i]} in
            -h|--help)
                return
                ;;
            -*)
                continue
                ;;
            *)
                cmd_offset=$((i+1))
                break
        esac
    done

    if [[ $cmd_offset -gt 0 ]]; then
        _command_offset "${cmd_offset}"
        return
    fi
}
