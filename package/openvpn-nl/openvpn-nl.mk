################################################################################
#
# openvpn-nl
#
################################################################################

OPENVPN_NL_VERSION = 2.3.9
OPENVPN_NL_SOURCE = openvpn-nl-$(OPENVPN_NL_VERSION).tar.gz
OPENVPN_NL_SITE = https://openvpn.fox-it.com/repos/source/$(OPENVPN_NL_VERSION)-nl2
OPENVPN_NL_DEPENDENCIES = host-pkgconf polarssl-nl
OPENVPN_NL_LICENSE = GPLv2
OPENVPN_NL_LICENSE_FILES = COPYRIGHT.GPL
OPENVPN_NL_AUTORECONF = YES
OPENVPN_NL_CONF_OPTS = \
	--disable-plugin-auth-pam \
	--enable-iproute2 \
	--with-crypto-library=polarssl \
    --disable-plugins \
    --disable-lzo

OPENVPN_NL_CONF_ENV = IFCONFIG=/sbin/ifconfig \
	NETSTAT=/bin/netstat \
	ROUTE=/sbin/route 


# BusyBox 1.21+ places the ip applet in the "correct" place
# but previous versions didn't.
ifeq ($(BR2_PACKAGE_IPROUTE2),y)
OPENVPN_NL_CONF_ENV += IPROUTE=/sbin/ip
else ifeq ($(BR2_BUSYBOX_VERSION_1_19_X)$(BR2_BUSYBOX_VERSION_1_20_X),y)
OPENVPN_NL_CONF_ENV += IPROUTE=/bin/ip
else
OPENVPN_NL_CONF_ENV += IPROUTE=/sbin/ip
endif

define OPENVPN_NL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/src/openvpn/openvpn \
		$(TARGET_DIR)/usr/sbin/openvpn
endef

define OPENVPN_NL_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/openvpn/S60openvpn \
		$(TARGET_DIR)/etc/init.d/S60openvpn
endef

$(eval $(autotools-package))
