pragma solidity ^0.5.5;

// UNFINISHED

import "./TokenizeProperty.sol";
// import "../.deps/github/OpenZeppelin/openzeppelin-contracts/contracts/access/Roles.sol";

// @dev This contract allows investors to registerProperty for a crowdsale. 

contract PropertyRegistry is PropertyCoinSaleDeployer {
    using Roles for Roles.Role;
    
    event PermissionGranted(address indexed account);
    event PermissionRevoked(address indexed account);
    
    Roles.Role private permissions;
    
    address _owner;
    
    constructor () public {
        _owner = msg.sender;
        permissions.add(msg.sender);
    }
    
    modifier onlyOwner() {
        require(msg.sender == _owner, "You are not authorized to register propery for a crowdsale.");
        _;
    }
    
    function grantPermission(address account) onlyOwner public {
        require(account != address(0), "Entered zero address.");
        permissions.add(account);
        emit PermissionGranted(account);
    }
    
    function hasPermission(address account) public view returns(bool) {
        return permissions.has(account);
    }

}















