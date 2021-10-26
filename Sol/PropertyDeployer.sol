pragma solidity >=0.5.5;

// import "./RealEstateToken.sol";
import "./TokenSale.sol";
// import "./Permission.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PropertyCoinSaleDeployer {

    address public property_token_sale_address;
    address public property_token_address;
    address _owner;

    constructor() public {
        _owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == _owner, "You are not authorized to register propery for a crowdsale.");
        _;
    }
    
    function registerProperty(
        address payable beneficiary,
        string memory propertyName, 
        string memory tokenSymbol, 
        uint _totalSupply, 
        uint goal
        ) public onlyOwner {
            
            uint totalSupply = _totalSupply * (10**18);
            uint rate = totalSupply / goal;
        
            RealEstateCoin property_token = new RealEstateCoin(propertyName, tokenSymbol, 0);
            property_token_address = address(property_token);
        
            PropertyCoinSale property_sale = new PropertyCoinSale(beneficiary, rate, goal, _totalSupply, /* goal, now, now + 1 hours, */property_token);
            property_token_sale_address = address(property_sale);
        
            property_token.addMinter(property_token_sale_address);
            property_token.renounceMinter();
    }
    
}
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
