#!/bin/bash

echo "sudo apt install -y nodejs"
sudo apt install -y nodejs

echo "sudo apt install -y npm"
sudo apt install -y npm

echo "sudo npm install -g n"
sudo npm install -g n

echo "sudo n stable"
sudo n stable

echo "sudo npm install -g firebase-tools"
sudo npm install -g firebase-tools

echo "dart pub global activate flutterfire_cli"
dart pub global activate flutterfire_cli

export PATH="$PATH":"$HOME/.pub-cache/bin"

echo "firebase login"
firebase login

echo "flutterfire configure"
flutterfire configure
