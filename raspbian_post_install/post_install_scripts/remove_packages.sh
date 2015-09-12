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

# REMOVE USELESS PACKAGES (scratch, mathematica, games, ...)

# COMPLETELY REMOVE THE X SERVER ?

# see http://raspberrypi.stackexchange.com/questions/4745/how-to-uninstall-x-server-and-desktop-manager-when-running-as-headless-server
#     http://raspberrypi.stackexchange.com/questions/5258/how-can-i-remove-the-gui-from-raspbian-debian

TITLE="Remove packages"
QUESTION="Completely remove Xserver and all dependencies ?"

if (whiptail --title "${TITLE}" --yesno "${QUESTION}" 8 78) then
    echo "Remove Xserver."
    apt-get remove --auto-remove --purge "libx11-.*"
else
    echo "Keep Xserver."
fi


# SELECT A CUSTOM PACKAGE LIST TO REMOVE

TITLE="Remove Packages"
SUB_TITLE="Select package lists to remove"
DIR_BASE="${PI_ROOT_DIR}/remove_packages"

PKG_LIST_FILE=$(${PI_ROOT_DIR}/choose_packages_lists.sh "${TITLE}" "${SUB_TITLE}" "${DIR_BASE}")
echo "Package lists: ${PKG_LIST_FILE}"

for FILE in ${PKG_LIST_FILE}
do
    echo "Install ${DIR_BASE}/${FILE}:"
    echo $(tr '\n' ' ' < ${DIR_BASE}/${FILE})
    #aptitude purge $(tr '\n' ' ' < ${DIR_BASE}/${FILE})
    apt-get remove --auto-remove --purge $(tr '\n' ' ' < ${DIR_BASE}/${FILE})
done

