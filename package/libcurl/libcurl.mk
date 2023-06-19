################################################################################
#
# libcurl
#
################################################################################

HOST_LIBCURL_DEPENDENCIES = host-openssl
HOST_LIBCURL_CONF_OPTS = \
	--disable-manual \
	--disable-ntlm-wb \
	--disable-curldebug \
	--with-ssl \
	--without-gnutls \
	--without-mbedtls \
	--without-nss

HOST_LIBCURL_POST_PATCH_HOOKS += LIBCURL_FIX_DOT_PC

$(eval $(host-autotools-package))
