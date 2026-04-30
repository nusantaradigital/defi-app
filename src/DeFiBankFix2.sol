// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract DeFiBank {
    mapping(address => uint) public balances;
    event Deposited(address indexed user, uint amount);
    event Withdrew(address indexed user, uint amount);

    function depositBalance() public payable{
        require(msg.value > 0, "You Must Send ETH!");

        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Tambahkan guard 2
    bool internal locked;

    modifier noReentrant() {
        require(!locked, "Reentrant call");
        locked = true;
        _;
        locked = false;
    }

    function withdrawBalance() public noReentrant{
        uint amount = balances[msg.sender];
        require(amount > 0, "Insufficience Balance!");

        // update sate - guard 1
        balances[msg.sender] = 0;

        // kirim ETH dulu...
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer Invalid");

        emit Withdrew(msg.sender, amount);
    }
}