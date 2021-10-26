pragma solidity >=0.5.5;

import "./RealEstateToken.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";

contract PropertyCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale{
    
    constructor(
        address payable beneficiary,
        uint256 rate,
        uint cap,
        uint maxSupply,
        RealEstateCoin token
    )
        //  Pass the constructor parameters to the crowdsale contracts.
        Crowdsale (rate, beneficiary, token)
        
        // // Pass the constructor parameters to the capped crowdsale contracts. 
        CappedCrowdsale (cap) 
        
        public {
            // Empty constructor

        }
    
    
    
}





