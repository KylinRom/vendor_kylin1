# Copyright (C) 2014 ParanoidAndroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Add bootanimation based on xxhdpi xhdpi hdpi tvdpi resolution


# XXHDPI Devices
ifneq ($OVERLAY_TARGET,"xxhdpi")
    PRODUCT_COPY_FILES += \
        vendor/kylin/prebuilt/bootanimation/1920x1080.zip:system/media/bootanimation.zip
endif

# XHDPI Devices
ifneq ($OVERLAY_TARGET,"xhdpi")
    PRODUCT_COPY_FILES += \
        vendor/kylin/prebuilt/bootanimation/1280x720.zip:system/media/bootanimation.zip
endif

# HDPI Devices
ifneq ($OVERLAY_TARGET,"hdpi")
    PRODUCT_COPY_FILES += \
        vendor/kylin/prebuilt/bootanimation/800x480.zip:system/media/bootanimation.zip
endif

# TVDPI Devices
ifneq ($OVERLAY_TARGET,"tvdpi")
    PRODUCT_COPY_FILES += \
        vendor/kylin/prebuilt/bootanimation/1920x1200.zip:system/media/bootanimation.zip
endif
