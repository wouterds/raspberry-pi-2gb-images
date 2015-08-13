# Configure timezone
dpkg-reconfigure tzdata

# Configure locales
dpkg-reconfigure locales

# Get rid of the annoying locale warnings when installing stuff
echo "" >> ~/.bashrc
echo "export LANGUAGE=\"en_US.UTF-8\"" >> ~/.bashrc
echo "export LC_ALL=\"en_US.UTF-8\"" >> ~/.bashrc
echo "export LC_CTYPE=\"en_US.UTF-8\"" >> ~/.bashrc
echo "export LANG=\"en_US.UTF-8\"" >> ~/.bashrc

apt-get update
apt-get upgrade -y

# Install raspi-copies-and-fills
apt-get install raspi-copies-and-fills -y

# Improve performance for various apps by enabling hardware random number generator
echo "bcm2708-rng" >> /etc/modules
apt-get install rng-tools -y

# Install raspi-config
apt-get install raspi-config -y
# Run raspi-config
# - 1. expand filesystem
# - 8. advanced options > set desired hostname
# - Finish & reboot

# Install Raspberry Pi bootloader
apt-get install raspberrypi-bootloader -y

# Install some basic packages
apt-get install nano git htop -y

# Install sudo and
apt-get install sudo -y

# Add pi user
useradd -m -d /home/pi -p `openssl passwd -crypt "raspberry"` pi

# Give pi user sudo priveleges without asking for password
echo "" >> /etc/sudoers
echo "pi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Disable ssh login for root
echo "" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# Install zsh
apt-get install zsh -y

# Install oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Get rid of the annoying locale warnings when installing stuff in zsh shell
echo "" >> ~/.zshrc
echo "export LANGUAGE=\"en_US.UTF-8\"" >> ~/.zshrc
echo "export LC_ALL=\"en_US.UTF-8\"" >> ~/.zshrc
echo "export LC_CTYPE=\"en_US.UTF-8\"" >> ~/.zshrc
echo "export LANG=\"en_US.UTF-8\"" >> ~/.zshrc

# Network discovery
apt-get install avahi-daemon -y
insserv avahi-daemon

# Install Wifi drivers & tools
apt-get install wpasupplicant wireless-tools -y

# Network configuration
echo "auto wlan0" > /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto eth0" >> /etc/network/interfaces
echo "iface eth0 inet dhcp" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "allow-hotplug wlan0" >> /etc/network/interfaces
echo "iface wlan0 inet manual" >> /etc/network/interfaces
echo "wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf" >> /etc/network/interfaces
echo "wireless-power off" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "iface default inet dhcp" >> /etc/network/interfaces

# Wifi configuration
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "    ssid=\"NetworkName\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "    psk=\"password\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "    key_mgmt=WPA-PSK" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

# NodeJS install
cd /tmp
wget http://node-arm.herokuapp.com/node_latest_armhf.deb
dpkg -i node_latest_armhf.deb

# Update & upgrade, just to be sure
apt-get update
apt-get upgrade -y

# Cleanup
apt-get autoremove --purge -y
apt-get autoclean --purge
apt-get clean --purge

