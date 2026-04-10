#!/bin/bash

# SPDX-License-Identifier: AGPL-3.0-or-later

set -e

echo "installing shexli..."
pip install . --break-system-packages --no-warn-script-location

SHEXLI_BIN="$(python3 -m site --user-base)/bin/shexli"

echo "creating symlink in /usr/local/bin..."
sudo ln -sf "$SHEXLI_BIN" /usr/local/bin/shexli

echo "done shexli installed"
echo ""
shexli --help
