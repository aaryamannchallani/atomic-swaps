// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

interface IERC20 {
	function transfer(address recipient, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface Hasher {
  function hashString(string memory _toHash) external view returns (bytes32);
}

contract HLTC {
	address public recipient;
	address public admin;
	uint256 public amount;
	address public tokenAddress;  
	bytes32 public hash = '0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8';
	uint256 public lockTime;
	uint256 public timeLock = 10000 seconds;
  IERC20 public token;
  Hasher public hasher;

	constructor(address _recipient, address _tokenAddress, uint256 _amount, address _hasher) {
		admin = msg.sender;
		token = IERC20(_tokenAddress);
    hasher = Hasher(_hasher)
		amount = _amount;
		recipient = _recipient;
	}

  function fund() external {
    lockTime = block.timestamp;
    token.transferFrom(msg.sender, this(address), amount);
  }

  function withdraw(string memory _secret) external {
    require(hasher.hashString(_secret) == hash, '[ATOMIC-SWAP] Wrong secret.');
    secret = _secret;
    token.transfer(recipient, amount);
  }
  
  function refund() external {
    require(block.timestamp > lockTime + timeLock, '[ATOMIC-SWAP] Too early.');
    token.transfer(admin, amount);
  }
}
