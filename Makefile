USER_INSTALL_PREFIX=$(HOME)/.local
USER_COMPLETION_INSTALL_PATH=$(HOME)/.config/bash_completion.d/

SYSTEM_INSTALL_PREFIX=/usr/local
SYSTEM_COMPLETION_INSTALL_PATH=/etc/bash_completion.d/

COMPLETION=git-wip-completion.bash

DOC_FILES=git-wip.xml git-wip.1

%.xml: %.txt
	asciidoc -f asciidoc.conf -d manpage -b docbook -o $@ $<

%.1: %.xml
	xmlto man $<

user-install: $(DOC_FILES)
	install -D  git-wip $(USER_INSTALL_PREFIX)/bin/
	install -DT git-wip $(USER_INSTALL_PREFIX)/bin/git-local
	install -m 644 -D 						\
		$(COMPLETION)						\
		$(USER_COMPLETION_INSTALL_PATH)/$(COMPLETION)
	install -m 0644 git-wip.1 $(USER_INSTALL_PREFIX)/share/man/man1

install: $(DOC_FILES)
	install -D  git-wip $(SYSTEM_INSTALL_PREFIX)/bin/
	install -DT git-wip $(SYSTEM_INSTALL_PREFIX)/bin/git-local
	install -m 644 -D 						\
		$(COMPLETION)						\
		$(SYSTEM_COMPLETION_INSTALL_PATH)/$(COMPLETION)

clean:
	rm -f $(DOC_FILES)
