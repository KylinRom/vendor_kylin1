VERSION_A = 5
VERSION_B = 0

# BUILDTYPE: DAILY BETAx RELEASE
BUILDTYPE := DAILY

# TODO build user check

KYLIN_VERSION := $(VERSION_A).$(VERSION_B)-$(BUILDTYPE)

ifeq ($(BUILDTYPE), DAILY)
    KYLIN_VERSION := $(VERSION_A).$(VERSION_B)-$(BUILDTYPE)-$(shell date -u +%Y%m%d)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.kylin.version=$(KYLIN_VERSION) \
  ro.kylin.releasetype=$(BUILDTYPE) \
  ro.modversion=$(KYLIN_VERSION) \

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

