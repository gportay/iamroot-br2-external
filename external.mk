include $(sort $(wildcard $(BR2_EXTERNAL_IAMROOT_PATH)/package/*/*.mk))

.PHONY: rm-build
rm-build:
	rm -rf $(BUILD_DIR)/*/*

.PHONY: rm-target
rm-target:
	rm -rf $(BASE_TARGET_DIR)
	rm -rf $(BUILD_DIR)/*/.stamp_target_installed
