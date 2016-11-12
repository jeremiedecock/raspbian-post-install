#!/bin/bash

# The MIT License
# 
# Copyright (c) 2014,2015,2016 Jérémie DECOCK <jd.jdhp@gmail.com>
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

ASK_TO_REBOOT=0

export PI_ROOT_DIR=$(dirname $0)
export PI_SCRIPTS_COMMON_DIR=${PI_ROOT_DIR}/common/scripts
export PI_SCRIPTS_RASPBIAN_DIR=${PI_ROOT_DIR}/scripts
export PI_SCRIPTS_PACKAGES_LISTS_DIR=${PI_ROOT_DIR}/packages_lists/raspbian_latest

# COMMON FUNCTIONS ############################################################

# Ask for confirmation and execute FN_NAME
rpi_confirm() {
    FN_NAME="$1"
    FN_MSG="$2"

    echo "${FN_MSG}"
    read -p "(C)ontinue,(s)kip,(q)uit ? " RESP

    case ${RESP} in
        s) return 0
            ;;
        q) rpi_quit_fn
            ;;
    esac

    ${FN_NAME}
}

# Global initialization function
rpi_init_fn() {
    # TODO: load state variables
    echo ""
}

# Exit function
rpi_quit_fn() {
    # TODO: save state variables
    exit 0
}

# FUNCTIONS ###################################################################

# CHANGE THE 'pi' PASSWORD TO SOMETHING MORE SECURE
fn_pi_pwd() {
    passwd pi
}

# CHANGE THE ROOT PASSWORD TO SOMETHING MORE SECURE
fn_root_pwd() {
    passwd
}

###############################################################################

# CHECK ID
if [ $(id -u) -ne 0 ]
then
    echo "Script must be run as root. Try 'sudo ./install.sh'\n"
    exit 1
fi

rpi_init_fn

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/setup_l10n.sh "Localization and internationalization (setup keyboard, locale and timezone)"

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/resize_partition.sh "Resize partitions"

# NTP works out of the box with recent raspbian releases
#rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/install_ntp.sh "Install and configure ntp"

rpi_confirm fn_pi_pwd "Change the 'pi' password to something more secure"

rpi_confirm fn_root_pwd "Change the root password to something more secure"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/install_mpeg2_vc1_keys.sh "Install MPEG2 and VC1 license keys"

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/set_hostname.sh "Configure hostname"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/remove_packages.sh "Remove useless packages"

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/update_packages.sh "Update packages"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/install_packages.sh "Install packages"

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/enable_ssh.sh "Enable SSH"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/enable_spi.sh "Enable SPI"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/enable_picamera.sh "Enable RPI camera"

rpi_confirm ${PI_SCRIPTS_COMMON_DIR}/ssh_reconfigure.sh "Change the ssh host keys (as all rpi images have the same keys)"

rpi_confirm ${PI_SCRIPTS_RASPBIAN_DIR}/memory_split.sh "Memory split"

rpi_quit_fn
