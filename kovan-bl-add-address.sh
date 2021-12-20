# Set FORK RPC URL
export ETH_RPC_URL=https://kovan.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

# deploy
export ETH_FROM=0x00d16F998e1f62fB2a58995dd2042f108eB800d1

# export TREASURY_WALLET=[UPDATE TO MULTISIG ADDRESS TO RECEIEVE ETH SHARES]
# export LIQUIDITY_WALLET=[UPDATE TO LIQUIDITY WALLET TO RECEIVE LP TOKENS]

export TOKEN_ADDRESS=0xb8d60A1488f199028bE2A2Fe7E9bCeeD4c3729c6
export ETH_GAS_PRICE=6000000000
export ETH_GAS=$(seth estimate $TOKEN_ADDRESS "blackList(address)" "0x37da0d6e65FA0AA1080BE73C5f20Df6E91f7F194"  --rpc-url $ETH_RPC_URL)

seth send $TOKEN_ADDRESS "blackList(address)" "0x37da0d6e65FA0AA1080BE73C5f20Df6E91f7F194" --rpc-url $ETH_RPC_URL