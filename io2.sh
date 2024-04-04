#!/bin/bash

# Download ionet-setup.sh script
curl -L https://github.com/ionet-official/io-net-official-setup-script/raw/main/ionet-setup.sh -o ionet-setup.sh

# Give execute permission and run ionet-setup.sh
chmod +x ionet-setup.sh && ./ionet-setup.sh

# Download launch_binary_linux script
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux

# Give execute permission to launch_binary_linux
chmod +x launch_binary_linux
