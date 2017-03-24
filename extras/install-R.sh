#!/bin/bash

sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update -qq
sudo apt-get -y install r-base

# Needed to install devtools
sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev
