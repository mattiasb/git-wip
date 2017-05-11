#!/bin/bash

# Copyright ⓒ 2017 Mattias Bengtsson
#
# git-wip is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# git-wip is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with git-wip.  If not, see <http://www.gnu.org/licenses/>.
#
# Author: Mattias Bengtsson <mattias.jc.bengtsson@gmail.com>

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
