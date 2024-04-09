#!/bin/bash
sudo apt-get install expect -y
curl -L https://raw.githubusercontent.com/krakh75/io/main/al.exp -o al.exp
chmod +x al.exp && ./al.exp
