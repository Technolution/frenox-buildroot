#############################################################
#
# myman
#
#############################################################
MYMAN_VERSION = 2009-10-30
MYMAN_SOURCE = myman-wip-$(MYMAN_VERSION).tar.gz
MYMAN_SITE = https://sourceforge.net/projects/myman/files/myman-cvs/myman-cvs-$(MYMAN_VERSION)
MYMAN_INSTALL_TARGET = YES
MYMAN_DEPENDENCIES = ncurses

define MYMAN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) -f simple.mk smallman CFLAGS="$(TARGET_CFLAGS)" CROSS="$(TARGET_CROSS)"
endef

define MYMAN_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 package/myman/myman $(TARGET_DIR)/usr/bin/myman
	$(INSTALL) -D -m 0755 $(@D)/smallman $(TARGET_DIR)/usr/lib/myman/smallman
	$(INSTALL) -D -m 0644 $(@D)/chr/khr2h.txt $(TARGET_DIR)/usr/lib/myman/chr/khr2h.txt
	$(INSTALL) -D -m 0644 $(@D)/spr/spr2h.txt $(TARGET_DIR)/usr/lib/myman/spr/spr2h.txt
	$(INSTALL) -D -m 0644 $(@D)/lvl/maze.txt $(TARGET_DIR)/usr/lib/myman/lvl/maze.txt
endef

$(eval $(generic-package))
