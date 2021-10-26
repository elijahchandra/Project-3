pragma solidity >=0.5.5;

import "./TokenSale.sol";


contract PropertyCoinSaleDeployer {

    address public property_token_sale_address;
    address public property_token_address;
    address _owner;

    constructor() public {
        _owner = msg.sender;
    }
    
    function registerProperty(
        address payable beneficiary,
        string memory propertyName, 
        string memory tokenSymbol, 
        uint _maxSupply, 
        uint goal
        ) public authorizedOwner {
            
            uint maxSupply = _maxSupply * (10**18);
            uint rate = maxSupply / goal;
        
            RealEstateCoin property_token = new RealEstateCoin(propertyName, tokenSymbol, maxSupply, beneficiary);
            property_token_address = address(property_token);
        
            PropertyCoinSale property_sale = new PropertyCoinSale(beneficiary, rate, goal, property_token);
            property_token_sale_address = address(property_sale);
        
            property_token.addMinter(property_token_sale_address);
            property_token.renounceMinter();
    }
    
}
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
