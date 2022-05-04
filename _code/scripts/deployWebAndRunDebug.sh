#!/bin/bash

Clear='\e[0m'
Black='\e[0;30;47m'
Red='\e[0;31;47m'
Green='\e[0;32;47m'
Brown='\e[0;33;47m'
Blue='\e[0;34;47m'
Magenta='\e[0;35;47m'
Cyan='\e[0;36;47m'
LightGray='\e[0;37;47m'
DarkGray='\e[1;30;40m'
DarkRed='\e[1;31;40m'
DarkGreen='\e[1;32;40m'
Yellow='\e[1;33;40m'
DarkBlue='\e[1;34;40m'
DarkMagenta='\e[1;35;40m'
DarkCyan='\e[1;36;40m'
White='\e[1;37;40m'

p_path='C:/Users/1/Project/enuyoung_crawller_flutter/_code'
echo "$p_path"
cd $p_path

#echo -e "${Red}"
#echo "----python3.9 changeVersion.py"
#python changeVersion.py
#echo -e "${Clear}"

echo "----flutter build web"
{ buildInfo="$(flutter build web --verbose)"; } 2>/dev/null
if [[ !($buildInfo =~ "exiting with code 0") ]]; then
	echo "$buildInfo"
	echo -e "${Magenta}----에러 발생했어요${Clear}"
	exit 1
fi

echo "cp -r ./build/web/* ../"
cp -r ./build/web/* ../

#echo "----git fetch origin"
#git fetch origin
#
#echo "----git add --all"
#git add --all
#
#echo "----git commit -m $1"
#git commit -m "$1"
#
#echo "----git push origin"
#git push origin
#
#bash runDebug.sh