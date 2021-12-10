# Set FORK RPC URL
export ETH_RPC_URL=https://kovan.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

# deploy
export ETH_FROM=0x00d16F998e1f62fB2a58995dd2042f108eB800d1

# export TREASURY_WALLET=[UPDATE TO MULTISIG ADDRESS TO RECEIEVE ETH SHARES]
# export LIQUIDITY_WALLET=[UPDATE TO LIQUIDITY WALLET TO RECEIVE LP TOKENS]

export TOKEN_ADDRESS=0x023fDe3766E86E317604d89f3bD4B973Dc2f174D
export ETH_GAS_PRICE=150000000000
export ETH_GAS=$(seth estimate $TOKEN_ADDRESS "setMaxTxBPS(uint256)" 10000 --rpc-url $ETH_RPC_URL)

seth send $TOKEN_ADDRESS "setMaxTxBPS(uint256)" 10000 --rpc-url $ETH_RPC_URL