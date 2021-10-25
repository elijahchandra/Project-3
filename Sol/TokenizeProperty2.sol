pragma solidity >=0.5.5;

import "./RealEstateToken.sol";
// import "./Permission.sol";
// import "../.deps/github/OpenZeppelin/openzeppelin-contracts/contracts/access/Roles.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


contract PropertyCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        address payable beneficiary,
        uint256 rate, // amount of TKNbits per wei
        uint goal, 
        uint cap,
        uint open,
        uint close,
        RealEstateCoin token
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale (rate, beneficiary, token)
        
        // Pass the constructor parameters to the refundable crowdsale contracts.
        RefundableCrowdsale (goal) 
        
        // Pass the constructor parameters to the capped crowdsale contracts. 
        CappedCrowdsale (cap) 
        
        TimedCrowdsale (open, close) 
        public {
            // Empty constructor
        }
}

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
        
            PropertyCoinSale property_sale = new PropertyCoinSale(beneficiary, rate, goal, goal, now, now + 1 hours, property_token);
            property_token_sale_address = address(property_sale);
        
            property_token.addMinter(property_token_sale_address);
            property_token.renounceMinter();
    }
    
}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
