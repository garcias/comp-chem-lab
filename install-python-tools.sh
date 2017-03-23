#!/bin/bash

sudo apt-get update -qq
sudo apt-get install -y python-virtualenv
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
# sudo apt-get -y install ipython ipython-notebook 
# sudo apt-get -y install python-pip python-dev python-virtualenv

virtualenv venv
. venv/bin/activate
pip install --upgrade pip 
pip install requests[security] --no-cache-dir 
pip install jupyter --no-cache-dir 
pip install pandas --no-cache-dir 
pip install matplotlib --no-cache-dir 
pip install seaborn --no-cache-dir 
deactivate
