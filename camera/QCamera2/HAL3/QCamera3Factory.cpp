/* Copyright (c) 2012-2015, The Linux Foundataion. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above
*       copyright notice, this list of conditions and the following
*       disclaimer in the documentation and/or other materials provided
*       with the distribution.
*     * Neither the name of The Linux Foundation nor the names of its
*       contributors may be used to endorse or promote products derived
*       from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
* ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
* BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
* SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
* BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
* OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
* IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*/

#define LOG_TAG "QCamera3Factory"
//#define LOG_NDEBUG 0

#include <stdlib.h>
#include <utils/Log.h>
#include <utils/Errors.h>
#include <hardware/camera3.h>

#include "../util/QCameraFlash.h"
#include "QCamera3Factory.h"

using namespace android;

namespace qcamera {

QCamera3Factory *gQCamera3Factory = NULL;

/*===========================================================================
 * FUNCTION   : QCamera3Factory
 *
 * DESCRIPTION: default constructor of QCamera3Factory
 *
 * PARAMETERS : none
 *
 * RETURN     : None
 *==========================================================================*/
QCamera3Factory::QCamera3Factory()
{
    mCallbacks = NULL;
    mNumOfCameras = get_num_of_cameras();
}

/*===========================================================================
 * FUNCTION   : ~QCamera3Factory
 *
 * DESCRIPTION: deconstructor of QCamera2Factory
 *
 * PARAMETERS : none
 *
 * RETURN     : None
 *==========================================================================*/
QCamera3Factory::~QCamera3Factory()
{
}

/*===========================================================================
 * FUNCTION   : get_number_of_cameras
 *
 * DESCRIPTION: static function to query number of cameras detected
 *
 * PARAMETERS : none
 *
 * RETURN     : number of cameras detected
 *==========================================================================*/
int QCamera3Factory::get_number_of_cameras()
{
    if (!gQCamera3Factory) {
        gQCamera3Factory = new QCamera3Factory();
        if (!gQCamera3Factory) {
            ALOGE("%s: Failed to allocate Camera3Factory object", __func__);
            return 0;
        }
    }
    return gQCamera3Factory->getNumberOfCameras();
}

/*===========================================================================
 * FUNCTION   : get_camera_info
 *
 * DESCRIPTION: static function to query camera information with its ID
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @info      : ptr to camera info struct
 *
 * RETURN     : int32_t type of status
 *              NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::get_camera_info(int camera_id, struct camera_info *info)
{
    return gQCamera3Factory->getCameraInfo(camera_id, info);
}

/*===========================================================================
 * FUNCTION   : set_callbacks
 *
 * DESCRIPTION: static function to set callbacks function to camera module
 *
 * PARAMETERS :
 *   @callbacks : ptr to callback functions
 *
 * RETURN     : NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::set_callbacks(const camera_module_callbacks_t *callbacks)
{
    return gQCamera3Factory->setCallbacks(callbacks);
}

/*===========================================================================
 * FUNCTION   : open_legacy
 *
 * DESCRIPTION: Function to open older hal version implementation
 *
 * PARAMETERS :
 *   @hw_device : ptr to struct storing camera hardware device info
 *   @camera_id : camera ID
 *   @halVersion: Based on camera_module_t.common.module_api_version
 *
 * RETURN     : 0  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::open_legacy(const struct hw_module_t* module,
            const char* id, uint32_t halVersion, struct hw_device_t** device)
{
    return -ENOSYS;
}

/*===========================================================================
 * FUNCTION   : set_torch_mode
 *
 * DESCRIPTION: Attempt to turn on or off the torch mode of the flash unit.
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @on        : Indicates whether to turn the flash on or off
 *
 * RETURN     : 0  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::set_torch_mode(const char* camera_id, bool on)
{
    return gQCamera3Factory->setTorchMode(camera_id, on);
}

/*===========================================================================
 * FUNCTION   : getNumberOfCameras
 *
 * DESCRIPTION: query number of cameras detected
 *
 * PARAMETERS : none
 *
 * RETURN     : number of cameras detected
 *==========================================================================*/
int QCamera3Factory::getNumberOfCameras()
{
    return mNumOfCameras;
}

/*===========================================================================
 * FUNCTION   : getCameraInfo
 *
 * DESCRIPTION: query camera information with its ID
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @info      : ptr to camera info struct
 *
 * RETURN     : int32_t type of status
 *              NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::getCameraInfo(int camera_id, struct camera_info *info)
{
    int rc;
    ALOGV("%s: E, camera_id = %d", __func__, camera_id);

    if (!mNumOfCameras || camera_id >= mNumOfCameras || !info ||
        (camera_id < 0)) {
        return -ENODEV;
    }

    rc = QCamera3HardwareInterface::getCamInfo(camera_id, info);
    ALOGV("%s: X", __func__);
    return rc;
}

/*===========================================================================
 * FUNCTION   : setCallbacks
 *
 * DESCRIPTION: set callback functions to send asynchronous notifications to
 *              frameworks.
 *
 * PARAMETERS :
 *   @callbacks : callback function pointer
 *
 * RETURN     :
 *              NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::setCallbacks(const camera_module_callbacks_t *callbacks)
{
    int rc = NO_ERROR;
    mCallbacks = callbacks;

    rc = QCameraFlash::getInstance().registerCallbacks(callbacks);
    if (rc != 0) {
        ALOGE("%s : Failed to register callbacks with flash module!", __func__);
    }

    return rc;
}

/*===========================================================================
 * FUNCTION   : cameraDeviceOpen
 *
 * DESCRIPTION: open a camera device with its ID
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @hw_device : ptr to struct storing camera hardware device info
 *
 * RETURN     : int32_t type of status
 *              NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::cameraDeviceOpen(int camera_id,
                    struct hw_device_t **hw_device)
{
    int rc = NO_ERROR;
    if (camera_id < 0 || camera_id >= mNumOfCameras)
        return -ENODEV;

    QCamera3HardwareInterface *hw = new QCamera3HardwareInterface(
            camera_id, mCallbacks);
    if (!hw) {
        ALOGE("Allocation of hardware interface failed");
        return NO_MEMORY;
    }
    rc = hw->openCamera(hw_device);
    if (rc != 0) {
        delete hw;
    }
    return rc;
}

/*===========================================================================
 * FUNCTION   : camera_device_open
 *
 * DESCRIPTION: static function to open a camera device by its ID
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @hw_device : ptr to struct storing camera hardware device info
 *
 * RETURN     : int32_t type of status
 *              NO_ERROR  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::camera_device_open(
    const struct hw_module_t *module, const char *id,
    struct hw_device_t **hw_device)
{
    if (module != &HAL_MODULE_INFO_SYM.common) {
        ALOGE("Invalid module. Trying to open %p, expect %p",
            module, &HAL_MODULE_INFO_SYM.common);
        return INVALID_OPERATION;
    }
    if (!id) {
        ALOGE("Invalid camera id");
        return BAD_VALUE;
    }
    return gQCamera3Factory->cameraDeviceOpen(atoi(id), hw_device);
}

struct hw_module_methods_t QCamera3Factory::mModuleMethods = {
    .open = QCamera3Factory::camera_device_open,
};

/*===========================================================================
 * FUNCTION   : setTorchMode
 *
 * DESCRIPTION: Attempt to turn on or off the torch mode of the flash unit.
 *
 * PARAMETERS :
 *   @camera_id : camera ID
 *   @on        : Indicates whether to turn the flash on or off
 *
 * RETURN     : 0  -- success
 *              none-zero failure code
 *==========================================================================*/
int QCamera3Factory::setTorchMode(const char* camera_id, bool on)
{
    int retVal(0);
    long cameraIdLong(-1);
    int cameraIdInt(-1);
    char* endPointer = NULL;
    errno = 0;
    QCameraFlash& flash = QCameraFlash::getInstance();

    cameraIdLong = strtol(camera_id, &endPointer, 10);

    if ((errno == ERANGE) ||
            (cameraIdLong < 0) ||
            (cameraIdLong >= static_cast<long>(get_number_of_cameras())) ||
            (endPointer == camera_id) ||
            (*endPointer != '\0')) {
        retVal = -EINVAL;
    } else if (on) {
        cameraIdInt = static_cast<int>(cameraIdLong);
        retVal = flash.initFlash(cameraIdInt);

        if (retVal == 0) {
            retVal = flash.setFlashMode(cameraIdInt, on);
            if ((retVal == 0) && (mCallbacks != NULL)) {
                mCallbacks->torch_mode_status_change(mCallbacks,
                        camera_id,
                        TORCH_MODE_STATUS_AVAILABLE_ON);
            } else if (retVal == -EALREADY) {
                // Flash is already on, so treat this as a success.
                retVal = 0;
            }
        }
    } else {
        cameraIdInt = static_cast<int>(cameraIdLong);
        retVal = flash.setFlashMode(cameraIdInt, on);

        if (retVal == 0) {
            retVal = flash.deinitFlash(cameraIdInt);
            if ((retVal == 0) && (mCallbacks != NULL)) {
                mCallbacks->torch_mode_status_change(mCallbacks,
                        camera_id,
                        TORCH_MODE_STATUS_AVAILABLE_OFF);
            }
        } else if (retVal == -EALREADY) {
            // Flash is already off, so treat this as a success.
            retVal = 0;
        }
    }

    return retVal;
}

}; // namespace qcamera

