#
# Copyright 2013 The Android Open Source Project
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

ifeq ($(strip $(USE_DEVICE_SPECIFIC_CAMERA)),true)
  ifneq ($(filter msm8960 msm8226 msm8974,$(TARGET_BOARD_PLATFORM)),)
    ifneq ($(USE_CAMERA_STUB),true)
      ifneq ($(BUILD_TINY_ANDROID),true)
        include $(call all-subdir-makefiles)
      endif
    endif
  endif
endif
