const HTLC = artifacts.require('HTLC');
const ethers = require('ethers');

module.exports = async function(deployer, network, addresses) {
  const [a1, a2] = addresses;

  if (network === 'kovan') {
    // sUSD
    await deployer.deploy(HTLC, a2, '0xF92e70301E26AaDeCCEc5016b7D0167DAF416d72', ethers.utils.parseEther('5'), {from: a1});
    const htlc = await htlc.deployed();
    const token = new ethers.Contract('0xF92e70301E26AaDeCCEc5016b7D0167DAF416d72', abi, provider);
    await token.approve(htlc.address, ethers.utils.formatEther('5'));
    await htlc.fund({from: a1});
  } else if(network === 'binanceTestnet') {
    // DAI
    await deployer.deploy(HTLC, a1, '0xEC5dCb5Dbf4B114C9d0F65BcCAb49EC54F6A0867', ethers.utils.parseEther('5'), {from: a2});
    const htlc = await htlc.deployed();
    const token = new ethers.Contract('0xEC5dCb5Dbf4B114C9d0F65BcCAb49EC54F6A0867', abi, provider);
    await token.approve(htlc.address, ethers.utils.formatEther('5'));
    await htlc.fund({from: a2});
  }
}