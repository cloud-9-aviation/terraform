#!/usr/bin/env bash

set -euxo pipefail

USER=vscode
GROUP=vscode

DIRS=(
    "/home/vscode/.terraform.d"
    "/home/vscode/.cache"
    "/home/vscode/.config"
)

for DIR in "${DIRS[@]}"; do
    if [ "$(stat -c '%U:%G' "$DIR")" != "$USER:$GROUP" ]; then
        sudo chown -Rc "$USER:$GROUP" "$DIR"
    fi
done

pre-commit install
