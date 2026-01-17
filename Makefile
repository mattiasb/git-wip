# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright 2016, Mattias Bengtsson <mattias.jc.bengtsson@gmail.com>
# Copyright 2017, Jonas Ådahl <jadahl@gmail.com>

################################################################################
## Makefile config

SHELL       := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.ONESHELL:
.SILENT:
MAKEFLAGS   += --warn-undefined-variables
MAKEFLAGS   += --no-builtin-rules
NULL        :=

################################################################################
## Macros

define show
	echo "## $1" ;                                \
	{ $(foreach v,$2,echo $(v)=$($(v));) }        \
	| column -tL -o ' = ' -s '=' --table-right 1; \
	echo
endef

################################################################################
## XDG constants

XDG_DATA_HOME   ?= $(HOME)/.local/share
XDG_STATE_HOME  ?= $(HOME)/.local/state
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME  ?= $(HOME)/.cache

################################################################################
## GNU standard installation directories

# See https://www.gnu.org/prep/standards/html_node/Directory-Variables.html

ifeq ($(shell id -u), 0)
	prefix     ?= /usr/local
	sysconfdir ?= /etc/
else
	prefix     ?= $(shell realpath -m $(XDG_DATA_HOME)/..)
	sysconfdir ?= $(XDG_CONFIG_HOME)/
endif
datarootdir        ?= $(prefix)/share
bindir             ?= $(prefix)/bin
mandir             ?= $(datarootdir)/man
man1dir            ?= $(mandir)/man1
bashcompdir        ?= $(sysconfdir)/bash_completion.d

################################################################################

targets             = $(bindir)/git-wip                                        \
                      $(bindir)/git-local                                      \
                      $(man1dir)/git-wip.1                                     \
                      $(bashcompdir)/git-wip-completion.bash

install: $(targets)

clean:
	rm -f build/*

%/:
	mkdir -p $@

$(bindir)/git-local: $(bindir)/git-wip
	echo -e "$(<) —→ $(@)"
	ln -s $(<) $(@)

$(bindir)/%: % | $(bindir)/
	echo -e "$(<) =⇒ $(@)"
	install -m '0755' -DT $(<) $(@)

$(bashcompdir)/%: % | $(bashcompdir)/
	echo -e "$(<) =⇒ $(@)"
	install -m '0644' -DT $(<) $(@)

$(man1dir)/%.1: build/%.1 | $(man1dir)/
	echo -e "$(<) =⇒ $(@)"
	install -m '0644' -DT $(<) $(@)

build/%.1: build/%.xml
	if ! out=$$(xmlto man $(<) -o build/ 2>&1); then echo $${out}; fi

build/%.xml: %.txt | build/
	asciidoc -f asciidoc.conf -d manpage -b docbook -o $@ $<
