pragma solidity ^0.5.0;

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
        // @TODO: Fill in the constructor parameters!
        address payable wallet,
        uint rate, // 1 TKNbit per wei or 1 TKN per Ether.
        uint goal, // Crowdsale goal of 10,000 wei
        uint cap, // Max 100,000 of wei accepted in the crowdsale.
        uint open,
        uint close,
        RealEstateCoin token
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale (rate, wallet, token)
        
        // Pass the constructor parameters to the refundable crowdsale contracts.
        RefundableCrowdsale (goal) 
        
        // Pass the constructor parameters to the capped crowdsale contracts. 
        CappedCrowdsale (cap) 
        
        TimedCrowdsale (open, close) public
        {
            // constructor can be empty    
        }
    
    // function fastforward() public {
    //     fakenow = block.timestamp;
    // } @dev function used to mine new block when using Ganache 
}

contract PropertyCoinSaleDeployer {

    address public property_token_sale_address;
    address public property_token_address;

    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable beneficiary // This address will receive all Ether raised by the contract
    )
        public
    {
        // @TODO: create the RealEstateCoin and keep its address handy
        // @param name, symbol, initialSupply
        RealEstateCoin token = new RealEstateCoin (name, symbol, 240000000000000000);
        token_address = address(token);

        // @TODO: create the PropertyCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        PropertyCoinSale pupper_sale = new PropertyCoinSale(beneficiary, 1, 240000000000000000, 240000000000000000, now, now + 5 minutes, token);
        token_sale_address = address(pupper_sale);

        // make the PropertyCoinSale contract a minter, then have the PropertyCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
    
    // function registerPropertyCoin(
}
