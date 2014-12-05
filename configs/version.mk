VERSION := $(ROM_VERSION_MAJOR).$(ROM_VERSION_MINOR)-$(ROM_BUILD_TYPE)-$(shell date -u +%Y%m%d)

export ROM_VERSION := $(VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(ROM_VERSION) \
    ro.$(VENDOR).version=$(VERSION)
