# Set FORK RPC URL
export ETH_RPC_URL=https://mainnet.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

# deploy
export ETH_FROM=0x00D1f6D4513B75E8fb95509ad7683a354F2000D1

# export TREASURY_WALLET=[UPDATE TO MULTISIG ADDRESS TO RECEIEVE ETH SHARES]
# export LIQUIDITY_WALLET=[UPDATE TO LIQUIDITY WALLET TO RECEIVE LP TOKENS]

export TOKEN_ADDRESS=0x91bCf850c5E2C07eF195E549c7bBea7463724BB9
export ETH_GAS_PRICE=200000000000
export ETH_GAS=$(seth estimate $TOKEN_ADDRESS "setTaxEnabled(bool)" true --rpc-url $ETH_RPC_URL)

seth send $TOKEN_ADDRESS "setTaxEnabled(bool)" true --rpc-url $ETH_RPC_URL