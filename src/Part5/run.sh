#!/bin/bash

spawn-fcgi -p 8080 ./miniserver
service nginx start
tail -f /dev/null