#!/bin/bash

# The MIT License
# 
# Copyright (c) 2014,2015 Jérémie DECOCK <jd.jdhp@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# INSTALL MPEG2 AND VC1 LICENSE KEYS

TITLE="Install MPEG2 and VC1 license keys"
MSG="Where is the license key file?"
DEFAULT_FILE="/root/codecs_rpi.txt"

LICENSE_KEY_PATH=$(whiptail --inputbox "${MSG}" 8 78 "${DEFAULT_FILE}" --title "${TITLE}" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    if [ -f ${LICENSE_KEY_PATH} ] ; then
        cat ${LICENSE_KEY_PATH} >> /boot/config.txt
    else
        TITLE="File error"
        MSG="Can't read ${LICENSE_KEY_PATH}"
        whiptail --title "${TITLE}" --msgbox "${MSG}" 8 78
    fi
fi

