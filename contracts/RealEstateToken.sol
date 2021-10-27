pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract RealEstateCoin is ERC20, ERC20Detailed, ERC20Mintable {
    using SafeMath for uint;
    
    address payable beneficiary;
    address payable walletAddress;
    uint shares;
    uint maxSupply;
    uint sharePercent;
    uint amount;

    constructor(
        string memory name,
        string memory symbol,
        uint _maxSupply,
        address payable _beneficiary
    )
        ERC20Detailed(name, symbol, 18)
        public
    {
        maxSupply = _maxSupply;
        beneficiary = _beneficiary;
    }

    mapping (address => bool) private investor;
    address payable [] private investorsList;
    
    function registerForDividends() public {
        require(balanceOf(msg.sender) > 0, "You are not an investor.");
        require(investor[msg.sender] != true, "Address already confirmed.");
        investor[msg.sender] = true;
        investorsList.push(msg.sender);
    }

    /**
        Allows renter to deposit their monthly rent.
        Loops through an array of Investors for the property and distributes dividends.
    **/
    function payRent() payable public {
        uint points = msg.value/100;

        uint arrayLength = investorsList.length;
        for (uint i = 0; i < arrayLength; i++) {
            shares = ERC20.balanceOf(investorsList[i]);
            sharePercent = shares * 100 / maxSupply;
            amount = points * sharePercent;
            walletAddress = investorsList[i];
            walletAddress.transfer(amount);
        }
    }
}
