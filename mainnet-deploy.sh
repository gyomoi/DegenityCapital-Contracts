set -eo pipefail

# Build and perform optimization first
export DAPP_BUILD_OPTIMIZE=1
export DAPP_BUILD_OPTIMIZE_RUNS=1000000
dapp build

# select the filename and the contract in it
CONTRACT_NAME="ReFi"
PATTERN=".contracts[\"src/$CONTRACT_NAME.sol\"].$CONTRACT_NAME"

# get the constructor's signature
ABI=$(jq -r "$PATTERN.abi" out/dapp.sol.json)
SIG=$(echo $ABI | seth --abi-constructor)

# get the bytecode from the compiled file
BYTECODE=0x$(jq -r "$PATTERN.evm.bytecode.object" out/dapp.sol.json)

# Set FORK RPC URL
export ETH_RPC_URL=https://mainnet.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

# deploy
export ETH_FROM=0x0d1234fB3670978cE165efb01855184C888bc660

export TREASURY_WALLET=0xe9F3ddC15e654e05507F8E6134C1761aC4faB076
export LIQUIDITY_WALLET=0xe9F3ddC15e654e05507F8E6134C1761aC4faB076

export ETH_GAS_PRICE=6000000000
export ETH_GAS=$(seth estimate --create $BYTECODE $SIG $TREASURY_WALLET $LIQUIDITY_WALLET "[$ETH_FROM]" --rpc-url $ETH_RPC_URL)
TOKEN_ADDRESS=$(dapp create $CONTRACT_NAME $TREASURY_WALLET $LIQUIDITY_WALLET "[$ETH_FROM]" --rpc-url $ETH_RPC_URL)

echo $TOKEN_ADDRESS
