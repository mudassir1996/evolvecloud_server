#!/bin/bash

# Create log file
log_file="installation.log"
touch $log_file

# Function to display the loading animation
loading() {
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Update package list
echo "Updating package list..." | tee -a $log_file
sudo apt-get update &>> $log_file &
loading $!

# Install tar, unzip
echo "Installing tar and unzip..." | tee -a $log_file
sudo apt-get install -y tar unzip &>> $log_file &
loading $!

# Install Apache2
echo "Installing Apache2..." | tee -a $log_file
sudo apt-get install -y apache2 &>> $log_file &
loading $!

# Install MariaDB
echo "Installing MariaDB..." | tee -a $log_file
sudo apt-get install -y mariadb-server &>> $log_file &
loading $!

# Install PHP7.4 and related modules
echo "Installing PHP7.4 and related modules..." | tee -a $log_file
sudo apt-get install -y libapache2-mod-php7.4 php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip &>> $log_file &
loading $!

# Install ImageMagick and related packages
echo "Installing ImageMagick and related packages..." | tee -a $log_file
sudo apt-get install -y imagemagick libmagickcore-6.q16-6-extra &>> $log_file &
loading $!

# Install Tesseract OCR
echo "Installing Tesseract OCR..." | tee -a $log_file
sudo apt-get install -y tesseract-ocr tesseract-ocr-all &>> $log_file &
loading $!

# Install OCRmyPDF
echo "Installing OCRmyPDF..." | tee -a $log_file
sudo apt-get install -y ocrmypdf &>> $log_file &
loading $!

# Install LibreOffice
echo "Installing LibreOffice..." | tee -a $log_file
sudo apt-get install -y libreoffice &>> $log_file &
loading $!

# Install MegaCMD
echo "Installing MegaCMD..." | tee -a $log_file
wget https://mega.nz/linux/repo/xUbuntu_20.04/amd64/megacmd-xUbuntu_20.04_amd64.deb
sudo apt install $HOME/megacmd-xUbuntu_20.04_amd64.deb &>> $log_file &
rm -f megacmd-xUbuntu_20.04_amd64.deb &>> $log_file &
loading $!

echo "Installation complete!" | tee -a $log_file
echo "Logs are stored in $log_file"
