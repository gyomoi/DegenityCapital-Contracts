
export ETH_RPC_URL=https://mainnet.infura.io/v3/c76efe7d627040729fe2c0e46045aa2c

export ETHERSCAN_API_KEY=FUNIEK3YMRF9CI9V5IAY6JD99XG31HBQVI

dapp verify-contract --async src/ChaosInu.sol:ChaosInu 0xC08Bcb0D835c8df9C159C8A1BD30862705596998 "" --rpc-url $ETH_RPC_URL