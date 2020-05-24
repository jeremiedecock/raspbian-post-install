#!/bin/bash

# The MIT License
# 
# Copyright (c) 2020 Jérémie DECOCK <jd.jdhp@gmail.com>
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


###############################################################################
# CE SCRIPT DOIT ÊTRE EXECUTÉ SUR UN PC SUR LEQUEL EST MONTÉ LA CARTE SD      #
# DU RPI (ET NON PAS DIRECTEMENT SUR LE RPI LUI MÊME)                         #
###############################################################################

# IMPORT COMMON FUNCTIONS #####################################################

export RASPBIAN_BOOT_DIR="/media/$USER/boot"
export RASPBIAN_ROOT_DIR="/media/$USER/rootfs"

export RPI_CONFIG_FILE_PATH="${RASPBIAN_BOOT_DIR}/config.txt"

export RPI_DEFAULT_USER=$USER
export RPI_DEFAULT_USER_GID=$(id -u)
export RPI_DEFAULT_USER_UID=$(id -g)

export RPI_HOME_PATH="${RASPBIAN_ROOT_DIR}/home/${RPI_DEFAULT_USER}"

#export PI_GROUPS=$(grep ":pi$" /media/jeremie/rootfs/etc/group  | awk -F':' '{print $1}' | head -c -1 | tr '\n' ',')
#export PI_GROUPS=$(grep ":pi$" /media/jeremie/rootfs/etc/group  | awk -F':' '{print $3}' | head -c -1 | tr '\n' ',')

CURRENT_PATH=$(pwd)

# ROTATE THE OFFICIAL 7" LCD SCREEN ###########################################

LINE_TO_APPEND="lcd_rotate=2"

# https://stackoverflow.com/a/3557165
grep -qxF "${LINE_TO_APPEND}" "${RPI_CONFIG_FILE_PATH}" || echo "${LINE_TO_APPEND}" >> "${RPI_CONFIG_FILE_PATH}"


# MAKE THE DEFAULT USER #######################################################

echo "Make user ${RPI_DEFAULT_USER} (uid=${RPI_DEFAULT_USER_UID} gid=${RPI_DEFAULT_USER_GID} groups=${PI_GROUPS})"


# SET THE NEW DEFAULT USER PASSWORD
# rem : on ne peut pas faire de chroot sur la carte SD d'un RPi car les executables présents sur la carte sont des executables ARM (et non pas x86)...
echo ""
echo "*** DEFAULT USER PASSWORD ***"

##sudo groupadd -R "${RASPBIAN_ROOT_DIR}" --gid=${RPI_DEFAULT_USER_GID} ${RPI_DEFAULT_USER}                                                   # <- groupadd échoue lamentablement quand on utilise --gid et -R
##sudo useradd -R "${RASPBIAN_ROOT_DIR}" --gid=${RPI_DEFAULT_USER_GID} --uid=${RPI_DEFAULT_USER_UID} -G "${PI_GROUPS}" ${RPI_DEFAULT_USER}    # <- groupadd échoue lamentablement quand on utilise -G et -R
sudo useradd -R "${RASPBIAN_ROOT_DIR}" --uid=${RPI_DEFAULT_USER_UID} -U -m -p "$(openssl passwd -6)" ${RPI_DEFAULT_USER}


# ALLOCATE GROUPS TO THE NEW DEFAULT USER (TAKE ALL "PI" GROUPS)
sudo sed -i "s/:pi$/:${RPI_DEFAULT_USER}/" "${RASPBIAN_ROOT_DIR}/etc/group"


# CHANGE THE DEFAULT USER
sudo sed -i "s/^autologin-user=pi$/autologin-user=${RPI_DEFAULT_USER}/" "${RASPBIAN_ROOT_DIR}/etc/lightdm/lightdm.conf"


# CLONE JDHP REPOSITORIES #####################################################

mkdir -p "${RPI_HOME_PATH}/git"

git clone --recurse-submodules git@github.com:jeremiedecock/raspbian-post-install.git         "${RPI_HOME_PATH}/git/raspbian-post-install"
git clone                      git@github.com:jeremiedecock/iptables-scripts.git              "${RPI_HOME_PATH}/git/iptables-scripts"
git clone                      git@github.com:jeremiedecock/tcp-wrapper-scripts.git           "${RPI_HOME_PATH}/git/tcp-wrapper-scripts"
git clone                      git@github.com:jeremiedecock/snippets-raspberry-pi-python.git  "${RPI_HOME_PATH}/git/snippets-raspberry-pi-python"

git clone git@jdhp.gitlab.com:jdhp/rpi-sensor-lib.git "${RPI_HOME_PATH}/git/rpi-sensor-lib"
git clone git@jdhp.gitlab.com:jdhp/timemgrpi.git      "${RPI_HOME_PATH}/git/timemgrpi"


# MAKE SSH KEYS AND CONFIGURE SSH #############################################

mkdir "${RPI_HOME_PATH}/.ssh"

cat ~/.ssh/id_rsa.pub > "${RPI_HOME_PATH}/.ssh/authorized_keys"

ssh-keygen -f "${RPI_HOME_PATH}/.ssh/id_dsa"
cat "${RPI_HOME_PATH}/.ssh/id_dsa.pub"

# CONFIGURE VIM AND TMUX #####################################################

cp -r ~/.vim "${RPI_HOME_PATH}/"
cp ~/.vimrc "${RPI_HOME_PATH}/"
cp ~/.tmux.conf "${RPI_HOME_PATH}/"


# MAKE A SCRIPT TO SET 7" SCREEN BRIGHTNESS ##################################

# https://www.raspberrypi.org/forums/viewtopic.php?t=214086
# https://raspberrypi.stackexchange.com/questions/46225/adjusting-the-brightness-of-the-official-touchscreen-display

echo '#!/bin/sh' > "${RPI_HOME_PATH}/brightness.sh"
echo 'echo "24" > /sys/class/backlight/rpi_backlight/brightness' >> "${RPI_HOME_PATH}/brightness.sh"
chmod a+x "${RPI_HOME_PATH}/brightness.sh"
