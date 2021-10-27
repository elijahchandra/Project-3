pragma solidity >=0.5.5;

import "./RealEstateToken.sol";

// @dev This contract allows investors to registerProperty for a crowdsale. 

contract Permission {
    using Roles for Roles.Role;
    
    address _owner;
    
    event PermissionGranted(address account);
    event PermissionRevoked(address account);
    
    Roles.Role permissions;
    
    constructor () public {
        _owner = msg.sender;
        permissions.add(msg.sender);
    }
    
    modifier onlyOwner() {
        require(msg.sender == _owner, "You are not authorized.");
        _;
    }
    
    modifier authorizedOwner() {
        require(permissions.bearer[msg.sender] == true, "Permission: You do not have permission to register property for crowdsale.");
        _;
    }
    
    function _grantPermission(address account) onlyOwner external {
        require(account != address(0), "Entered zero address.");
        permissions.add(account);
        emit PermissionGranted(account);
    }
    
    function _revokePermission(address account) onlyOwner external {
        require(account != address(0), "Entered zero address.");
        permissions.remove(account);
        emit PermissionRevoked(account);
    }
    
    function hasPermission(address account) external view returns(bool) {
        return permissions.has(account);
    }
}
