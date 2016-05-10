USER_INSTALL_PREFIX=$(HOME)/.local
SYSTEM_INSTALL_PREFIX=/usr/local

user-install:
	install -D git-wip $(USER_INSTALL_PREFIX)/bin/

install:
	install -D git-wip $(SYSTEM_INSTALL_PREFIX)/bin/
