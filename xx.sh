#!/bin/bash

# Run sudo -i without password prompt
sudo -i <<EOF
curl -L https://raw.githubusercontent.com/krakh75/io/main/re-run.sh -o re-run.sh && chmod +x ./re-run.sh && \
curl -L https://raw.githubusercontent.com/krakh75/io/main/edit.sh -o edit.sh && chmod +x ./edit.sh && \
./edit.sh re-run.sh
EOF
