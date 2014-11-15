VERSION_A = 5
VERSION_B = 0
BUILDTYPE = DAILY

# BUILDTYPE: DAILY BETAx RELEASE
KYLIN_BUILDTYPE := $(BUILDTYPE)

# TODO build user check

KYLIN_ROM_VERSION := $(VERSION_A).$(VERSION_B)-$(KYLIN_BUILDTYPE)

ifeq ($(KYLIN_BUILDTYPE), DAILY)
    KYLIN_ROM_VERSION := $(VERSION_A).$(VERSION_B)-$(KYLIN_BUILDTYPE)-$(shell date -u +%Y%m%d)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.kylin.version=$(KYLIN_ROM_VERSION) \
  ro.kylin.releasetype=$(KYLIN_BUILDTYPE) \
  ro.modversion=$(KYLIN_ROM_VERSION) \

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

