pragma solidity ^0.8.0;

contract Asset {
    address public owner;
    string public name;
    uint256 public value;
    
    constructor(string memory _name, uint256 _value) {
        owner = msg.sender;
        name = _name;
        value = _value;
    }
    
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership.");
        owner = newOwner;
    }
    
    function updateValue(uint256 newValue) public {
        require(msg.sender == owner, "Only the owner can update the value.");
        value = newValue;
    }
}
