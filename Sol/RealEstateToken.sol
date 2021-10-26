pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract RealEstateCoin is ERC20, ERC20Detailed, ERC20Mintable {
    using SafeMath for uint;
    
    // uint totalTokens;
    uint totalRent;

    constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
    )
        ERC20Detailed(name, symbol, 18)
        public
    {
        // constructor can stay empty
    } 

    function depositRent() public payable {
        totalRent = totalRent.add(msg.value);
        uint perShareAmount = totalRent/100000000000000000000;
        address payable walletAddress;
        
        uint arrayLength = ERC20.investorsList.length;
        for (uint i = 0; i < arrayLength; i++) {
            
            uint shares = ERC20._balances[ERC20.investorsList[i]];
            
            uint dividendAmount = shares.mul(perShareAmount);
            
            walletAddress = ERC20.investorsList[i];
            
            walletAddress.transfer(dividendAmount);
            
            // return walletAddress;
        }

    }
    
    function array() public view returns(uint) {
        return ERC20.investorsList.length;
    }
    
    function send() public payable {
        uint arrayLength = ERC20.investorsList.length;
        for (uint i = 0; i < arrayLength; i++) {
            
        address payable sendTo = ERC20.investorsList[i];
            
        sendTo.transfer(msg.value);
        
    }
    
    }
    
    function checkBalance(address to) public returns(bool) {
        uint arrayLength = ERC20.investorsList.length;
        for (uint i = 0; i < arrayLength; i++) {
            uint shares = ERC20._balances[ERC20.investorsList[i]];
            
            transfer(to, shares);
            
        }
        
        return true;
    }
}
    

