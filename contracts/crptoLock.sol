// SHREE RADHE
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract cryptoLock{
    struct Deposit {
        uint256 amount;
        uint256 unlockTime;
    }
    mapping(address=>Deposit) public balance;
    function deposit(uint _LockTime) public payable{
      require(msg.value > 0,"please send ethers more than 0");
      require(balance[msg.sender].amount == 0, "you have already locked amount");
      uint256 unlockTime = block.timestamp + _LockTime;
      balance[msg.sender]=Deposit({
        amount : msg.value,
        unlockTime : unlockTime
      });
    }
    function withdraw () public{
        uint256 depositedAmount =balance[msg.sender].amount ;
        require(depositedAmount > 0, "you have no any deposited amount");
        require(block.timestamp >= balance[msg.sender].unlockTime,"wait Bruh, your locked time is not complete yet");
    balance[msg.sender].amount = 0;
        balance[msg.sender].unlockTime = 0;
      (bool success,) = payable(msg.sender).call{value:depositedAmount}("");
       require(success, "money can't transfer!");
    }
}