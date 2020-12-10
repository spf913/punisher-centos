#!/usr/bin/with-contenv bash

# Shell Colors
set_shell_error() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[5m" # Style: blink
  echo -e "\e[31m" # Text Color: Red
}

set_shell_info() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[33m" # Text Color: Yellow
}

set_shell_pass() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[32m" # Text Color: Green
}

set_shell_warning() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[35m" # Text Color: Magenta
}

reset_shell() {
  echo -e "\e[0m" # Reset all shell attributes
}

# Check to see if packages are preinstalled
EPEL_INSTALLED=false
yum list installed epel-release
if [ $? -eq 0 ]; then

  set_shell_info
  echo "epel-release already installed skipping step"
  reset_shell

  EPEL_INSTALLED=true
fi

FORTUNE_INSTALLED=false
yum list installed fortune-mod
if [ $? -eq 0 ]; then

  set_shell_info
  echo "fortune-mod already installed skipping step"
  reset_shell

  FORTUNE_INSTALLED=true
fi

COWSAY_INSTALLED=false
yum list installed cowsay
if [ $? -eq 0 ]; then

  set_shell_info
  echo "cowsay already installed skipping step"
  reset_shell

  COWSAY_INSTALLED=true
fi

#Make sure packages can be installed
if ! $EPEL_INSTALLED; then
  yum -y install epel-release
  yum list installed epel-release
  if [ $? -ne 0 ]; then

    set_shell_error
    echo "TEST: installation of epel-release FAILED"
    reset_shell

    exit 1
  fi
  yum -y update
fi

if ! $FORTUNE_INSTALLED; then
  yum -y install fortune-mod
  yum list installed fortune-mod
  if [ $? -ne 0 ]; then

    set_shell_error
    echo -e "TEST: installation of fortune-mod FAILED"
    reset_shell

    exit 1
  fi
fi

if ! $COWSAY_INSTALLED; then
  yum -y install cowsay
  yum list installed cowsay
  if [ $? -ne 0 ]; then

    set_shell_error
    echo "TEST: installation of cowsay FAILED"
    reset_shell

    exit 1
  fi
fi

fortune | cowsay -n
if [ $? -ne 0 ]; then

  set_shell_error
  echo "TEST: really.. you got this far and cowsay FAILED"
  reset_shell

  exit 1
fi


# Clean up time
if ! $COWSAY_INSTALLED; then

  set_shell_info
  echo "uninstalling cowsay"
  reset_shell

  yum -y -q remove cowsay
fi

if ! $FORTUNE_INSTALLED; then

  set_shell_info
  echo "uninstalling fortune-mod"
  reset_shell

  yum -y -q remove fortune-mod
fi

if ! $EPEL_INSTALLED; then

  set_shell_info
  echo "uninstalling epel-release"
  reset_shell

  yum -y -q remove epel-release
fi

yum -y -q clean all

exit 0
