#!/bin/bash -eux

retry() {
  local COUNT=1
  local RESULT=0
  while [[ "${COUNT}" -le 10 ]]; do
    [[ "${RESULT}" -ne 0 ]] && {
      [ "`which tput 2> /dev/null`" != "" ] && tput setaf 1
      echo -e "\n${*} failed... retrying ${COUNT} of 10.\n" >&2
      [ "`which tput 2> /dev/null`" != "" ] && tput sgr0
    }
    "${@}" && { RESULT=0 && break; } || RESULT="${?}"
    COUNT="$((COUNT + 1))"

    # Increase the delay with each iteration.
    DELAY="$((DELAY + 10))"
    sleep $DELAY
  done

  [[ "${COUNT}" -gt 10 ]] && {
    [ "`which tput 2> /dev/null`" != "" ] && tput setaf 1
    echo -e "\nThe command failed 10 times.\n" >&2
    [ "`which tput 2> /dev/null`" != "" ] && tput sgr0
  }

  return "${RESULT}"
}


error() {
  if [ $? -ne 0 ]; then
    printf "\n\nnetwork failed...\n\n";
    exit 1
  fi
}

# To allow for autmated installs, we disable interactive configuration steps.
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

retry apt-get --assume-yes install systemd-resolved; error

mv /etc/network/interfaces /etc/network/interfaces.save

# Ping to test network connection
ping -c 1 1.1.1.1

default_interface=$(ip route get 1.1.1.1 | grep -Po '(?<=(dev ))(\S+)')

touch "/etc/systemd/network/10-${default_interface}.network"
printf '[Match]\nName=%s\n\n[Network]\nDHCP=yes\n' "${default_interface}" > "/etc/systemd/network/10-${default_interface}.network"

sed -i -e 's/DNS=.*/DNS=1.1.1.1 1.0.0.1/g' /etc/systemd/resolved.conf
sed -i -e 's/FallbackDNS=.*/FallbackDNS=8.8.8.8 8.8.4.4/g' /etc/systemd/resolved.conf

systemd-analyze cat-config systemd/resolved.conf

systemctl disable networking.service
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-resolved
