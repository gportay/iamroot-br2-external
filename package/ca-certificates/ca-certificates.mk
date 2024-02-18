################################################################################
#
# ca-certificates
#
################################################################################

define HOST_CA_CERTIFICATES_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) clean all
endef

define HOST_CA_CERTIFICATES_INSTALL_CMDS
	$(INSTALL) -d -m 0755 $(HOST_DIR)/share/ca-certificates
	$(INSTALL) -d -m 0755 $(HOST_DIR)/etc/ssl/certs
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install DESTDIR=$(HOST_DIR)
	rm -f $(HOST_DIR)/usr/sbin/update-ca-certificates
endef

define HOST_CA_CERTIFICATES_GEN_BUNDLE
	# Remove any existing certificates under /etc/ssl/certs
	rm -f $(HOST_DIR)/etc/ssl/certs/*

	# Create symlinks to certificates under /etc/ssl/certs
	# and generate the bundle
	cd $(HOST_DIR) ;\
	for i in `find usr/share/ca-certificates -name "*.crt" | LC_COLLATE=C sort` ; do \
		ln -sf ../../../$$i etc/ssl/certs/`basename $${i} .crt`.pem ;\
		cat $$i ;\
	done >$(BUILD_DIR)/ca-certificates.crt

	# Create symlinks to the certificates by their hash values
	$(HOST_DIR)/bin/c_rehash $(HOST_DIR)/etc/ssl/certs

	# Install the certificates bundle
	$(INSTALL) -D -m 644 $(BUILD_DIR)/ca-certificates.crt \
		$(HOST_DIR)/etc/ssl/certs/ca-certificates.crt
endef
HOST_CA_CERTIFICATES_POST_INSTALL_HOOKS += HOST_CA_CERTIFICATES_GEN_BUNDLE

$(eval $(host-generic-package))
