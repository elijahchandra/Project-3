pragma solidity ^0.5.5;

import "./RealEstateToken.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PropertyCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    // uint public fakenow = block.timestamp; @dev check fastforward function below

    constructor(
        address payable beneficiary,
        uint256 rate, // 1 TKNbit per wei or 1 TKN per Ether.
        uint goal, // Crowdsale goal of 10,000 wei
        uint cap, // Max 100,000 of wei accepted in the crowdsale.
        uint open,
        uint close,
        uint totalSupply,
        RealEstateCoin token
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale (rate, beneficiary, token)
        
        // Pass the constructor parameters to the refundable crowdsale contracts.
        RefundableCrowdsale (goal) 
        
        // Pass the constructor parameters to the capped crowdsale contracts. 
        CappedCrowdsale (cap) 
        
        TimedCrowdsale (open, close) public{}
        
        
    function tokenRate() public view returns(uint256) {
        return rate;
    }
}

contract PropertyCoinSaleDeployer {

    address public property_token_sale_address;
    address public property_token_address;

    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        uint totalSupply,
        uint goal,
        address payable beneficiary // This address will receive all Ether raised by the contract
    )
        public
    {
        // uint totalSupply = _totalSupply * (10**18);
        uint rate = totalSupply / goal;
        uint cap = goal;
        
        // @TODO: create the RealEstateCoin and keep its address handy
        // @param name, symbol, initialSupply
        RealEstateCoin token = new RealEstateCoin (name, symbol, 0);
        property_token_address = address(token);

        // @TODO: create the PropertyCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        PropertyCoinSale property_sale = new PropertyCoinSale(beneficiary, rate, goal, cap, now, now + 4 weeks, totalSupply, token);
        property_token_sale_address = address(property_sale);

        // make the PropertyCoinSale contract a minter, then have the PropertyCoinSaleDeployer renounce its minter role
        token.addMinter(property_token_sale_address);
        token.renounceMinter();
    }
    
    // function registerPropertyCoin(
}
