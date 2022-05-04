#!/bin/bash

p_path='/config/workspace/enuyoung_crawller_flutter/_code'
echo "$p_path"
cd $p_path

echo "sudo apt install gdebi-core wget"
sudo apt -y install gdebi-core wget

echo "sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 

echo "sudo gdebi google-chrome-stable_current_amd64.deb"
sudo gdebi google-chrome-stable_current_amd64.deb


echo "sudo rm -rf google-chrome-stable_current_amd64.deb"
sudo rm -rf google-chrome-stable_current_amd64.deb