#
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

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    persist.audio.handset.mic.type=digital \
    persist.audio.dualmic.config=endfire \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicecomm=true \
    persist.audio.fluence.voicerec=false \
    persist.audio.fluence.speaker=false
    ro.config.vc_call_vol_steps=7 \
    ro.config.media_vol_steps=25

# Camera
PRODUCT_DEFAULT_PROPERTY_OVERIDES += \
    camera.disable_zsl_mode=1

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608 \
    ro.sf.lcd_density=480

# DRM
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Hardware Composer
PRODUCT_PROPERTY_OVERRIDES += \
    persist.hwc.mdpcomp.enable=true

# HWUI
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.use_buffer_age=false

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.always_send_plmn=true \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.custom_ecc=1 \
    persist.radio.data_no_toggle=1 \
    persist.radio.mode_pref_nv10=1 \
    ro.ril.force_eri_from_xml=true \
    ro.telephony.call_ring.multiple=0 \
    ro.telephony.default_network=10 \
    telephony.lteOnCdmaDevice=1 \

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.radio.snapshot_enabled=1 \
    persist.radio.snapshot_timer=2 \
    persist.radio.use_cc_names=true \
    rild.libpath=/system/lib/libril-qc-qmi-1.so

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
    debug.qualcomm.sns.daemon=w \
    debug.qualcomm.sns.libsensor1=w \
    persist.debug.sensors.hal=w \
    ro.qti.sdk.sensors.gestures=false \
    ro.qti.sensors.amd=false \
    ro.qti.sensors.facing=false \
    ro.qti.sensors.game_rv=true \
    ro.qti.sensors.georv=true \
    ro.qti.sensors.max_accel_rate=200 \
    ro.qti.sensors.max_gamerv_rate=200 \
    ro.qti.sensors.max_geomag_rotv=60 \
    ro.qti.sensors.max_grav=200 \
    ro.qti.sensors.max_gyro_rate=200 \
    ro.qti.sensors.max_linacc=200 \
    ro.qti.sensors.max_orient=200 \
    ro.qti.sensors.pam=false \
    ro.qti.sensors.pedometer=false \
    ro.qti.sensors.step_counter=true \
    ro.qti.sensors.max_rotvec=200 \
    ro.qti.sensors.rmd=false \
    ro.qti.sensors.smd=true \
    ro.qti.sensors.smgr_mag_cal_en=true \
    ro.qti.sensors.step_counter=true \
    ro.qti.sensors.step_detector=true \
    ro.qti.sensors.tap=false \
    ro.qti.sensors.tilt=false \
    ro.qti.sensors.vmd=false

# Touchscreen
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# Vendor security patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lineage.build.vendor_security_patch=2016-10-05

# Wi-Fi
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15
