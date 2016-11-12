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

###############################################################################
# This script is part of the "Raspbian post-install scripts"                  #
# (https://github.com/jeremiedecock/raspbian-post-install) ; its purpose is   #
# to facilitate the installation of these script and minimize the number of   #
# commands to be typed by the user (this is especially convenient for users   #
# using a non-US keyboard layout).                                            #
###############################################################################

# CHECK ID

if [ $(id -u) -ne 0 ]
then
    echo "Script must be run as root. Try 'sudo ./rpi.sh'\n"
    exit 1
fi

# INSTALL APT-TRANSPORT-HTTPS (TO PREVENT SOME BUGS WITH APT-GET)

echo "INSTALL APT-TRANSPORT-HTTPS"

apt-get update
apt-get -y install apt-transport-https

# INSTALL GIT

echo "INSTALL GIT"

apt-get -y install git

# INSTALL RASPBIAN POST-INSTALL SCRIPTS IN /root

echo "INSTALL RASPBIAN POST-INSTALL SCRIPTS"

cd ~
git clone --recursive https://github.com/jeremiedecock/raspbian-post-install.git

# LAUNCH RASPBIAN POST-INSTALL SCRIPTS

echo "LAUNCH RASPBIAN POST-INSTALL SCRIPTS"

./raspbian-post-install/install.sh

