pragma solidity ^0.8.0;


import './Mindpay.sol';

contract Deposit {
    
   
    Mindpay public mindPayToken;
    
    address admin;
    
    address payable liquidityContractAddress;
    address payable stakeContractAddress;
    
    struct Deposits {
        uint amount;
        uint time;
        uint tokens;
        bool invested;
    }
    
    mapping(address => Deposits) public userDeposits;
   
    
    constructor(address payable _liquidityContractAddress, address payable _stakeContractAddress) {
         mindPayToken = new Mindpay();
         liquidityContractAddress = _liquidityContractAddress;
         stakeContractAddress = _stakeContractAddress;
         admin = msg.sender;
    }
    
    function createDeposit() external payable {
      uint oneNinetyOfEther = (msg.value * 90) / 100;   
      uint onTenthOfEther = msg.value - oneNinetyOfEther;
      require(msg.value >= 1 ether,"Minimum of 1 ether is required");
      uint tokens = (msg.value * 1000) / 1000000000000000000 ;
      if(msg.value >= 1 ether  && msg.value <= 5 ether) {
          uint newTokens = (tokens * 10) / 100 ; 
          tokens += newTokens;
         
      } else if(msg.value > 5 ) {
          uint newTokens = (tokens * 20) / 100 ;
          tokens += newTokens;
           
      }
      userDeposits[msg.sender] = Deposits(oneNinetyOfEther, block.timestamp + 15 minutes, tokens,true);
      liquidityContractAddress.transfer(onTenthOfEther);
      mindPayToken.mint(address(this),tokens);
     }
     
     function cancelInvestment() external {
         require(block.timestamp >= userDeposits[msg.sender].time,"Lock in period is not over yet");
         require(userDeposits[msg.sender].amount > 0 &&  userDeposits[msg.sender].tokens > 0,"You have cancelled or staked the investment");
         require(userDeposits[msg.sender].invested,"You have alread invested");
         address payable recipient = payable(msg.sender);
         recipient.transfer(userDeposits[msg.sender].amount);
         mindPayToken.burn(address(this),userDeposits[msg.sender].tokens);
         userDeposits[msg.sender].amount = 0;
         userDeposits[msg.sender].tokens = 0;
     }
     
     function stakeInvestment() external {
          require(block.timestamp >= userDeposits[msg.sender].time,"Lock in period is not over yet");
          require(userDeposits[msg.sender].amount > 0 &&  userDeposits[msg.sender].tokens > 0,"You have cancelled or staked the investment");
          require(userDeposits[msg.sender].invested,"You have already invested");
          liquidityContractAddress.transfer(userDeposits[msg.sender].amount);
          mindPayToken.transfer(stakeContractAddress,userDeposits[msg.sender].tokens);
          userDeposits[msg.sender].amount = 0;
          userDeposits[msg.sender].tokens = 0;
     }
     
     function updateLiquidityContractAddress(address payable _newAddress) external {
         require(msg.sender == admin);
         liquidityContractAddress = _newAddress;
     }
     
     function updateStakeContractAddress(address payable _newAddress) external {
         require(msg.sender == admin);
         stakeContractAddress = _newAddress;
     }
}