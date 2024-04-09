#!/bin/bash

# Download re-run.sh
curl -L https://raw.githubusercontent.com/krakh75/io/main/re-run.sh -o re-run.sh
# Make re-run.sh executable
chmod +x re-run.sh

# Download edit.sh
curl -L https://raw.githubusercontent.com/krakh75/io/main/edit.sh -o edit.sh
# Make edit.sh executable
chmod +x edit.sh

# Run edit.sh with re-run.sh as an argument
./edit.sh re-run.sh
