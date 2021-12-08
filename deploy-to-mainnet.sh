set -eo pipefail

# Build and perform optimization first
export DAPP_BUILD_OPTIMIZE=1
export DAPP_BUILD_OPTIMIZE_RUNS=1000000
dapp build

# select the filename and the contract in it
CONTRACT_NAME="RefarmCapital"
PATTERN=".contracts[\"src/$CONTRACT_NAME.sol\"].$CONTRACT_NAME"

# get the constructor's signature
ABI=$(jq -r "$PATTERN.abi" out/dapp.sol.json)
SIG=$(echo $ABI | seth --abi-constructor)

# get the bytecode from the compiled file
BYTECODE=0x$(jq -r "$PATTERN.evm.bytecode.object" out/dapp.sol.json)

# Set FORK RPC URL
export ETH_RPC_URL=UPDATE USING RPC MAINNET

# deploy
export ETH_FROM=[UPDATE ADDRESS WALLET MAS]

export TREASURY_WALLET=[UPDATE TO MULTISIG ADDRESS TO RECEIEVE ETH SHARES]
export LIQUIDITY_WALLET=[UPDATE TO LIQUIDITY WALLET TO RECEIVE LP TOKENS]

export ETH_GAS_PRICE=[GAS PRICE IN WEI]
export ETH_GAS=$(seth estimate --create $BYTECODE $SIG $TREASURY_WALLET $LIQUIDITY_WALLET "[$ETH_FROM]" --rpc-url $ETH_RPC_URL)
TOKEN_ADDRESS=$(dapp create $CONTRACT_NAME $TREASURY_WALLET $LIQUIDITY_WALLET "[$ETH_FROM]" --rpc-url $ETH_RPC_URL)

echo $TOKEN_ADDRESS
