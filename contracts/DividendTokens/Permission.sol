pragma solidity >=0.5.5;

// import "../.deps/github/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20Mintable.sol";
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
        require(msg.sender == _owner, "You are not authorized to register propery for a crowdsale.");
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
    
    // function hasPermission(address account) external view returns(bool) {
    //     return permissions.has(account);
    // }
    

}













