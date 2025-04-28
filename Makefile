.PHONY : all install uninstall clean dist

BIN_SCRIPT = emerge-do-all
SBIN_SCRIPTS = emerge-depclean emerge-install emerge-rebuild emerge-sync emerge-update
CONF_FILE = mhnnet-client.conf
SUDO_DROP_IN = 70-portage

all :
	@echo "Nothing to do."
	@echo "The scripts do not need to be built; this target only exists for compatability."

install :
	mkdir -p -m=0755 $(DESTDIR)/usr/bin
	mkdir -p -m=0755 $(DESTDIR)/usr/sbin
	cp -f $(addprefix scripts/,$(BIN_SCRIPT))   $(DESTDIR)/usr/bin/
	cp -f $(addprefix scripts/,$(SBIN_SCRIPTS)) $(DESTDIR)/usr/sbin/
	-chown root:root $(addprefix $(DESTDIR)/usr/bin/,$(BIN_SCRIPT)) $(addprefix $(DESTDIR)/usr/sbin/,$(SBIN_SCRIPTS))
	chmod 0755      $(addprefix $(DESTDIR)/usr/bin/,$(BIN_SCRIPT)) $(addprefix $(DESTDIR)/usr/sbin/,$(SBIN_SCRIPTS))
	mkdir -p -m=0755 $(DESTDIR)/etc
	mkdir -p -m=0755 $(DESTDIR)/etc/sudoers.d
	cp -f $(addprefix conf/,$(CONF_FILE))    $(DESTDIR)/etc/
	cp -f $(addprefix conf/,$(SUDO_DROP_IN)) $(DESTDIR)/etc/sudoers.d/
	-chown root:root $(addprefix $(DESTDIR)/etc/,$(CONF_FILE)) $(addprefix $(DESTDIR)/etc/sudoers.d/,$(SUDO_DROP_IN))
	chmod 0644      $(addprefix $(DESTDIR)/etc/,$(CONF_FILE)) $(addprefix $(DESTDIR)/etc/sudoers.d/,$(SUDO_DROP_IN))

uninstall :
	-rm -f $(addprefix $(DESTDIR)/usr/bin/,$(BIN_SCRIPT)) $(addprefix $(DESTDIR)/usr/sbin/,$(SBIN_SCRIPTS)) $(addprefix $(DESTDIR)/etc/sudoers.d/,$(SUDO_DROP_IN))
	-mv -f -b $(DESTDIR)/etc/$(CONF_FILE) $(DESTDIR)/etc/$(CONF_FILE).old

clean :
	@echo "Nothing to do."
	@echo "The scripts do not need to be cleaned up; this target only exists for compatability."

dist :
	set -e;\
	VERSION=$$(git tag --points-at HEAD --list 'v*');\
	[ -z $${VERSION} ] && echo "Error: GIT HEAD does not have a version tag" && exit 127;\
	tar -czvf mhnnet-client-scripts-$${VERSION}.tar.gz --group=root:0 --owner=root:0 --exclude='*.tar*' --exclude='*.git*' ./;\
