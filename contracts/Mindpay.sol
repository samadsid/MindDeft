pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Mindpay is ERC20 {
    
    // make it private after testing
    address public owner;
    
    constructor()  ERC20("MINDPAY","Mindpay") {
        owner = msg.sender;
    }
    
    function mint(address _minter, uint _amount) external onlyOwner {
        _mint(_minter,_amount);
    }
    
    function burn(address _burner, uint _amount) external onlyOwner {
        _burn(_burner, _amount);
    }
    
    function decimals() public pure override returns (uint8) {
        return 0;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
}