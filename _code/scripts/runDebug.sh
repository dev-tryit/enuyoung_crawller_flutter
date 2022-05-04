#!/bin/bash

hostName='0.0.0.0'
hostPort='5000'
renderer="canvaskit" #canvaskit, html

flutter pub get
bash killProcessPort.sh $hostPort
flutter run -d web-server --web-renderer $renderer --web-port $hostPort --web-hostname $hostName