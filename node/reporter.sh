#!/bin/bash

# remove is performed by deleting volume
# rm -rf ~/.yoda

echo "usage ketchup faculty bench jewel rocket latin absurd decide field party reunion cook entry scout scene miss box memory museum decorate guide few verify" \
   | bandd keys add $1 --recover --keyring-backend test

# config chain id
yoda config chain-id odin-testnet

# add validator to yoda config
yoda config validator $(bandd keys show $1 -a --bech val --keyring-backend test)

# setup execution endpoint
yoda config executor "rest:https://iv3lgtv11a.execute-api.ap-southeast-1.amazonaws.com/live/master?timeout=10s"

# setup broadcast-timeout to yoda config
yoda config broadcast-timeout "5m"

# setup rpc-poll-interval to yoda config
yoda config rpc-poll-interval "1s"

# setup max-try to yoda config
yoda config max-try 5

yoda keys add reporter

# send band tokens to reporters
for rec in $(yoda keys list -a)
do
  echo "y" | bandd tx bank send $1 $rec 1000000odin --broadcast-mode block --keyring-backend test --chain-id odin-testnet --node $2
done

# add reporter to bandchain
echo "y" | bandd tx oracle add-reporters $(yoda keys list -a) --from $1 --broadcast-mode block --keyring-backend test --chain-id odin-testnet --node $2

echo "Yoda configured"