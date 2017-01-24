################################################################################
#
# pkcs11-helper-nl
#
################################################################################

PKCS11_HELPER_NL_SITE = https://openvpn.fox-it.com/repos/source/2.3.9-nl2
PKCS11_HELPER_NL_VERSION = 1.10
PKCS11_HELPER_NL_SOURCE = pkcs11-helper-nl-$(PKCS11_HELPER_NL_VERSION).tar.gz

PKCS11_HELPER_NL_INSTALL_STAGING = YES
PKCS11_HELPER_NL_LICENSE = GPLv2
PKCS11_HELPER_NL_LICENSE_FILES = LICENSE

PKCS11_HELPER_NL_CONF_OPTS = \
    --disable-openssl \
    --disable-crypto-engine-openssl \
    --disable-crypto-engine-gnutls

PKCS11_HELPER_NL_AUTORECONF = YES

PKCS11_HELPER_NL_PRE_CONFIGURE_HOOKS += PKCS11_HELPER_NL_PRECONFIGURE

$(eval $(autotools-package))
