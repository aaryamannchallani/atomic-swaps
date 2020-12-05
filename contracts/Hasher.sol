// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

contract Hasher {
  function hashString(string memory _toHash) external view returns (bytes32) {
    return keccak256(abi.encodePacked(_toHash));
  }
}