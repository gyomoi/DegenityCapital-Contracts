1. Contract deployed with 100.000.000.000 REFARM https://kovan.etherscan.io/tx/0x3322a18a30c6e47092f07f2dd296260b60147c1a9d774e82747d51f64929bb86
2. Burn 65.000.000.000 REFARM https://kovan.etherscan.io/tx/0x705ba7e1850bd38e30fff42175ee12389b0f27db693065534d905a3d5a435fc5
3. Add Liquidity to uniswap v2 35.000.000.000/3ETH https://kovan.etherscan.io/tx/0xb73dc46840a92ae2e271533fb92c5db5e64b090be353922262577c8221cc6a83
4. Trade enabled https://kovan.etherscan.io/tx/0x02fcc27a8fa0941472bb61f432ea8c40d412e3ff372ddc35f275d7b6fe1c7cd2
5. Swap ETH to REFARM here https://app.uniswap.org/#/swap?use=v2&inputCurrency=ETH&outputCurrency=0x9cceb72d8926a6ab8c158aec79dfbc26d0849d89
6. Example Swap https://kovan.etherscan.io/tx/0x8368b7140a60994a71eefc1247f5ec3f5fc410a551ec7ebf7610f46b9bbfc88e

Min amount to hold to receive dividend is 1.000.000 REFARM
This account should receive dividend after the next users buy/sell 0x3ea3fcb5eba7e40a58ff03e5feb9b0a9366935aa

pairnya dah bener https://kovan.etherscan.io/address/0xb5afc7cbc34b31ba8845219c8b8d355e221ac61b

Kenapa dividendnya 0 ya?

Kita mulai dari withdrawableDividendOf

dia return ini

    return accumulativeDividendOf(account) - withdrawnDividends[account];

Terus cuman return gini

    int256 a = int256(magnifiedDividendPerShare * balanceOf(account));
    int256 b = magnifiedDividendCorrections[account]; // this is an explicit int256 (signed)
    return uint256(a + b) / magnitude;

balanceOf() -> 310954780835074309137895185
magnifiedDividendPerShare -> 0 sebelum dividen trackernya di execute fungsi ini

    function distributeDividends() public payable {
        require(_totalSupply > 0);
        if (msg.value > 0) {
            magnifiedDividendPerShare =
                magnifiedDividendPerShare +
                ((msg.value * magnitude) / _totalSupply);
            emit DividendsDistributed(msg.sender, msg.value);
            totalDividendsDistributed += msg.value;
        }
    }

berarti cari kapan dia ngirim ETH ke divident tracker ya.

dia dikirim saat `_executeSwap`

`_executeSwap` jalan setiap kali transfer.
