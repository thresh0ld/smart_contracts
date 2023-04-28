// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IERC777 {
    function balanceOf(address owner) external view returns (uint256);
}

contract ProofOfFunds {
    address public owner; 
    address public erc777TokenAddress;
    uint256 public requiredBalance;
    
    constructor(address _erc777TokenAddress, uint256 _requiredBalance) {
        owner = msg.sender;
        erc777TokenAddress = _erc777TokenAddress;
        requiredBalance = _requiredBalance;
    }
    
    function verify(address account) public view returns (bool) {
        IERC777 token = IERC777(erc777TokenAddress);
        return token.balanceOf(account) >= requiredBalance;
    }
    
    function updateRequiredBalance(uint256 _requiredBalance) public {
        require(msg.sender == owner, "Only the owner can update the required balance.");
        requiredBalance = _requiredBalance;
    }
    
    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        address payable payableOwner = payable(owner);
        payableOwner.transfer(address(this).balance);
    }
    
    receive() external payable {
        // do nothing
    }
}
