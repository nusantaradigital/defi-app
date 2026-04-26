// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract DeFiBank {
    mapping(address => uint) public balances;
    event Deposited(address indexed user, uint amount);
    event Withdrew(adress indexed user, uint amount);

    function depositBalance() public payable{
        require(msg.value > 0, "You Must Send ETH!");

        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, amount);
    }

    function withdrawBalance() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "Insufficience Balance!");

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer Invalid");

        balances[msg.sender] = 0;
        emit Withdrew(msg.sender, amount);
    }
}