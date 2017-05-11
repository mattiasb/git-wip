USER_INSTALL_PREFIX=$(HOME)/.local
USER_COMPLETION_INSTALL_PATH=$(HOME)/.config/bash_completion.d/

SYSTEM_INSTALL_PREFIX=/usr/local
SYSTEM_COMPLETION_INSTALL_PATH=/etc/bash_completion.d/

COMPLETION=git-wip-completion.bash

user-install:
	install -D  git-wip $(USER_INSTALL_PREFIX)/bin/
	install -DT git-wip $(USER_INSTALL_PREFIX)/bin/git-local
	install -m 644 -D 						\
		$(COMPLETION)						\
		$(USER_COMPLETION_INSTALL_PATH)/$(COMPLETION)

install:
	install -D  git-wip $(SYSTEM_INSTALL_PREFIX)/bin/
	install -DT git-wip $(SYSTEM_INSTALL_PREFIX)/bin/git-local
	install -m 644 -D 						\
		$(COMPLETION)						\
		$(SYSTEM_COMPLETION_INSTALL_PATH)/$(COMPLETION)
