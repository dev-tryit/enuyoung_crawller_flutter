#!/bin/bash

line=$(lsof -t -i:$1 | wc -l)
if [ "$line" -gt "0" ]; then
    kill -9 $(lsof -t -i:$1)
fi