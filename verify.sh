export ETHERSCAN_API_KEY=4QMXF315AJ4CIJB9H214IXIBDUMC8FJRUA
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
export ETH_RPC_URL=https://kovan.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

# deploy
export ETH_FROM=0x00d16F998e1f62fB2a58995dd2042f108eB800d1

export TREASURY_WALLET=0x6B8adc4Fd538073a2A9314b8CE5fc6490Bd00919
export LIQUIDITY_WALLET=0x00d16F998e1f62fB2a58995dd2042f108eB800d1

TOKEN_ADDRESS=0xe2332d7F9ABA5f2F7b7109026a797a720B6976E8

echo $TOKEN_ADDRESS

echo "Verifying contract ..."
# Verify the contract
dapp verify-contract --async src/RefarmCapital.sol:RefarmCapital $TOKEN_ADDRESS $TREASURY_WALLET $LIQUIDITY_WALLET "[$ETH_FROM]" --rpc-url $ETH_RPC_URL
echo $TOKEN_ADDRESS