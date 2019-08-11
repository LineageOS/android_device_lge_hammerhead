#
# Copyright (C) 2013 The Android Open-Source Project
# Copyright (C) 2019 The LineageOS Project
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
#

DEVICE_PATH := device/motorola/hammerhead

# Platform
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := $(DEVICE_PATH)/bluetooth/vnd_hammerhead.txt

# Board
BOARD_USES_SECURE_SERVICES := true
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOOTLOADER_BOARD_NAME := hammerhead
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31 androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02900000 --tags_offset 0x02700000
TARGET_KERNEL_CONFIG := lineageos_hammerhead_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/hammerhead

# Binder
TARGET_USES_64_BIT_BINDER := true

# Camera
# Exempts services from 9.0's mutex restrictions
TARGET_PROCESS_SDK_VERSION_OVERRIDE :=/system/bin/cameraserver=22
USE_DEVICE_SPECIFIC_CAMERA:= true
USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY:= true

# Dex-preopt
# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true

# Display
# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024
# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024
OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x02000000U
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_HAS_HH_VSYNC_ISSUE := true
TARGET_TOUCHBOOST_FREQUENCY:= 1200
TARGET_USES_ION := true
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000

# Encryption
TARGET_KEYMASTER_SKIP_WAITING_FOR_QSEE := true

# Fonts
EXCLUDE_SERIF_FONTS := true
SMALLER_FONT_FOOTPRINT := true

# GNSS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
TARGET_NO_RPC := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02900000 --tags_offset 0x02700000
TARGET_KERNEL_CONFIG := lineageos_hammerhead_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/hammerhead

# Legacy Hacks
# Enables additional sepolicy
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS:= true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 23068672
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 734003200
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 23068672
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13725837312
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Recovery
TARGET_RECOVERY_FSTAB = $(DEVICE_PATH)/rootdir/fstab.hammerhead

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)/releasetools

# SE Policy
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy
BOARD_SEPOLICY_M4DEFS += vensys=\(vendor\|system/vendor\)
ifneq ($(TARGET_BUILD_VARIANT),user)
   SELINUX_IGNORE_NEVERALLOWS := true
endif

# Wi-Fi
# Defined first because later flags use it
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcmdhd.bin"
WPA_SUPPLICANT_VERSION           := VER_0_8_X

-include vendor/lge/hammerhead/BoardConfigVendor.mk
