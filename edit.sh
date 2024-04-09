#!/bin/bash

# Check if the user provided a filename
if [ -z "$1" ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# Open the file in nano
nano "$1"
