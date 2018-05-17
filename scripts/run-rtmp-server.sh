#!/bin/bash

docker run --rm --name="rtmp-server" -d -p 1935:1935 -p 8080:8080 jasonrivers/nginx-rtmp
