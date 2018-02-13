LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := HammerheadDoze
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res \
     $(TOP)/packages/resources/devicesettings/res

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
