// SHREE RADHE
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleStorage{
    uint256 public count;
    function Increment() public{
        count+=1;
    }
    function Decrement() public{
        count-=1;
    }
}