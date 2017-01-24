################################################################################
#
# polarssl-nl
#
################################################################################

POLARSSL_NL_SITE = https://openvpn.fox-it.com/repos/source/2.3.9-nl2
POLARSSL_NL_VERSION = 1.2.19-1
POLARSSL_NL_SOURCE = polarssl-nl-$(POLARSSL_NL_VERSION).tar.gz
POLARSSL_NL_CONF_OPTS = -DUSE_PKCS11_HELPER_LIBRARY=OFF \
	-DENABLE_PROGRAMS=$(if $(BR2_PACKAGE_POLARSSL_NL_PROGRAMS),ON,OFF)
#POLARSSL_NL_DEPENDENCIES = pkcs11-helper-nl

POLARSSL_NL_INSTALL_STAGING = YES
POLARSSL_NL_LICENSE = GPLv2
POLARSSL_NL_LICENSE_FILES = LICENSE

define POLARSSL_NL_DISABLE_ASM
	$(SED) '/^#define POLARSSL_NL_HAVE_ASM/d' $(@D)/include/polarssl-nl/config.h
endef

# ARM in thumb mode breaks debugging with asm optimizations
# Microblaze asm optimizations are broken in general
# MIPS R6 asm is not yet supported
ifeq ($(BR2_ENABLE_DEBUG)$(BR2_ARM_INSTRUCTIONS_THUMB)$(BR2_ARM_INSTRUCTIONS_THUMB2),yy)
POLARSSL_NL_POST_CONFIGURE_HOOKS += POLARSSL_NL_DISABLE_ASM
else ifeq ($(BR2_microblaze),y)
POLARSSL_NL_POST_CONFIGURE_HOOKS += POLARSSL_NL_DISABLE_ASM
else ifeq ($(BR2_MIPS_CPU_MIPS32R6)$(BR2_MIPS_CPU_MIPS64R6),y)
POLARSSL_NL_POST_CONFIGURE_HOOKS += POLARSSL_NL_DISABLE_ASM
endif

$(eval $(cmake-package))
