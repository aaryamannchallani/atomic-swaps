// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

interface IERC20 {
	function transfer(address recipient, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract HTLC {
	address public recipient;
	address public admin;
	uint256 public amount;
	address public tokenAddress;  
	bytes32 public hash = 0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8;
	uint256 public lockTime;
	uint256 public timeLock = 10000 seconds;
  string public secret;
  IERC20 public token;

	constructor(address _recipient, address _tokenAddress, uint256 _amount) {
		admin = msg.sender;
		token = IERC20(_tokenAddress);
		amount = _amount;
		recipient = _recipient;
	}

  function fund() external {
    lockTime = block.timestamp;
    token.transferFrom(msg.sender, address(this), amount);
  }

  function withdraw(string memory _secret) external {
    require(keccak256(abi.encodePacked(_secret)) == hash, '[ATOMIC-SWAP] Wrong secret.');
    secret = _secret;
    token.transfer(recipient, amount);
  }
  
  function refund() external {
    require(block.timestamp > lockTime + timeLock, '[ATOMIC-SWAP] Too early.');
    token.transfer(admin, amount);
  }
}
