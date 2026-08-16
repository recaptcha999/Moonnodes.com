#!/bin/bash
DIR="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd "$DIR"

# Locate system PHP binary
if type php 2>/dev/null; then
    PHP_BINARY=$(type -p php)
elif [ -f ./bin/php7/bin/php ]; then
    PHP_BINARY="./bin/php7/bin/php"
else
    echo "[ERROR] Could not find a working PHP binary."
    exit 1
fi

# Locate MCPE v0.15.10 Server Core file (.phar)
if [ -f ./Genisys.phar ]; then
    POCKETMINE_FILE="./Genisys.phar"
elif [ -f ./PocketMine-MP.phar ]; then
    POCKETMINE_FILE="./PocketMine-MP.phar"
elif [ -f ./src/pocketmine/PocketMine.php ]; then
    POCKETMINE_FILE="./src/pocketmine/PocketMine.php"
else
    echo "[ERROR] Could not find Genisys.phar or PocketMine-MP.phar in this folder."
    exit 1
fi

# Execute server
LOOPS=0
while true; do
    if [ $LOOPS -gt 0 ]; then
        echo "Server restarted $LOOPS times."
    fi
    "$PHP_BINARY" "$POCKETMINE_FILE" "$@"
    echo "Restarting server in 5 seconds..."
    sleep 5
    ((LOOPS++))
done

