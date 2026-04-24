// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract DeFiBank {
    mapping (address => uint) public balances;
    event Deposited(address indexed user, uint amount);

    function depositBalance() public payable {
        require(msg.value > 0, "Must Send ETH");
        balances[msg.sender] += msg.value;
        
        emit Deposited(msg.sender, msg.value);
    }
}