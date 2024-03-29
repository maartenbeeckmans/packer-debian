#!/bin/bash -eux

ip addr
ip route

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
                printf "\n\napt failed...\n\n";
                exit 1
        fi
}

# To allow for autmated installs, we disable interactive configuration steps.
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

# If the apt configuration directory exists, we add our own config options.
if [ -d /etc/apt/apt.conf.d/ ]; then
  # Disable periodic activities of apt.
  printf "APT::Periodic::Enable \"0\";\n" >> /etc/apt/apt.conf.d/10periodic
  # Enable retries, which should reduce the number box buld failures resulting from a temporal network problems.
  printf "APT::Periodic::Enable \"0\";\n" >> /etc/apt/apt.conf.d/20retries
fi

# Keep the daily apt updater from deadlocking our installs.
systemctl stop apt-daily.service apt-daily.timer

# Remove the CDROM as a media source.
sed -i -e "/cdrom:/d" /etc/apt/sources.list

# Ensure the server includes any necessary updates.
retry apt-get --assume-yes -o Dpkg::Options::="--force-confnew" update; error
retry apt-get --assume-yes -o Dpkg::Options::="--force-confnew" upgrade; error
retry apt-get --assume-yes -o Dpkg::Options::="--force-confnew" dist-upgrade; error

# The packages users expect on a sane system.
retry apt-get --assume-yes install vim net-tools tree curl httpie wget htop iftop iotop tmux telnet silversearcher-ag dnsutils unzip tar sed; error
