// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "../src/DeFiBankVulner.sol";
import "../src/Attacker.sol";

contract AttackTest is Test {

    DeFiBank bank;
    Attacker attacker;

    address user = address(1);

    function setUp() public {
        // deploy contract
        bank = new DeFiBank();
        attacker = new Attacker(address(bank));

        // kasih ETH ke user
        vm.deal(user, 10 ether);

        // user deposit ke bank
        vm.prank(user);
        bank.depositBalance{value: 10 ether}();
    }

    function testAttack() public {
        // kasih ETH ke attacker
        vm.deal(address(attacker), 1 ether);

        // jalankan attack
        attacker.attack{value: 1 ether}();
        
        // cek hasil
        assertEq(address(bank).balance, 0);
    }
}