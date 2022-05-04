#!/bin/bash

p_path='C:/Users/1/Project/enuyoung_crawller_flutter/_code'
echo "$p_path"
cd $p_path

echo "rm -r ./build/windows/runner/Release/*"
rm -rf ./build/windows/runner/Release/*

echo "flutter build windows"
flutter build windows

echo "rm -r ../deploy/SumgoManager.zip"
rm -r ../deploy/SumgoManager.zip

echo "zip -r ../deploy/SumgoManager.zip ./build/windows/runner/Release/*"
zip ../deploy/SumgoManager.zip ./build/windows/runner/Release/*