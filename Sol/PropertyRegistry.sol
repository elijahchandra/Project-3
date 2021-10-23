pragma solidity >=0.5.5;

// UNFINISHED


import "./TokenizeProperty.sol";

// @dev This contract allows investors to registerProperty for a crowdsale. 

contract PropertyRegistry {
    using Roles for Roles.Role;
    
    address public sale_deployer_address;
    
    event PermissionGranted(address account);
    event PermissionRevoked(address account);
    
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
    
    // modifier onlyAuthorized() {
    //     require(permissions.has(msg.sender), "Permission: Not approved");
    //     _;
    // }
    
    function registerProperty(
        string memory propertyAddress, 
        string memory propertyTokenSymbol, 
        uint tokenSupply, 
        uint price, 
        address payable beneficiary
        ) public {
            
        require(permissions.has(msg.sender) || _owner == msg.sender, "Permission: Not approved");
        
        PropertyCoinSaleDeployer deployer = new PropertyCoinSaleDeployer(propertyAddress, propertyTokenSymbol, tokenSupply, price, beneficiary);
        sale_deployer_address = address(deployer);
    }
    
    function grantPermission(address account) onlyOwner public {
        require(account != address(0), "Entered zero address.");
        permissions.add(account);
        emit PermissionGranted(account);
    }
    
    function revokePermission(address account) onlyOwner public {
        require(account != address(0), "Entered zero address.");
        permissions.remove(account);
        emit PermissionRevoked(account);
    }
    
    function hasPermission(address account) public view returns(bool) {
        return permissions.has(account);
    }
    

}












