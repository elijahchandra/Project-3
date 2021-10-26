pragma solidity >=0.5.5;

import "./RealEstateToken.sol";
// import "./Permission.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PropertyCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale /*TimedCrowdsale, RefundablePostDeliveryCrowdsale*/ {
    
    // uint totalSupply2;
    // address payable walletAddress;
    // uint dividendAmount;

    constructor(
        address payable beneficiary,
        uint256 rate, // amount of TKNbits per wei
        // uint goal, 
        uint cap,
        uint totalSupply_,
        // uint open,
        // uint close,
        RealEstateCoin token
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale (rate, beneficiary, token)
        
        // // Pass the constructor parameters to the refundable crowdsale contracts.
        // RefundableCrowdsale (goal) 
        
        // // Pass the constructor parameters to the capped crowdsale contracts. 
        CappedCrowdsale (cap) 
        
        // TimedCrowdsale (open, close) 
        public {
            // Empty constructor
            // totalSupply2 = totalSupply_;
        }
        
    // function payDividends() external payable {
    //     // require(msg.value > 0, "You tried sending a 0 balance.");
    //     // totalFunds = totalFunds.add(msg.value);
    //     uint rentAmount = msg.value;
    //     uint perShareAmount = rentAmount/totalSupply2;
    //     uint shares;
        
    //     uint arrayLength = Crowdsale.addressList.length;
    //     for (uint i=0; i<arrayLength; i++) {
    //         shares = ERC20._balances[Crowdsale.addressList[i]];
    //         walletAddress = Crowdsale.addressList[i];
    //         dividendAmount = shares*perShareAmount;
            
    //         walletAddress.transfer(dividendAmount);
    //     }
        
            
            
    // }
    
    
    
}





