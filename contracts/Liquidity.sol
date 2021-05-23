pragma solidity ^0.8.0;


contract Liquidity {
    address payable admin;
    
    constructor() {
        admin = payable(msg.sender);
    }
    
    function transferEthers() external onlyAdmin {
        admin.transfer(address(this).balance);
    }
    
    
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    function changeAdmin(address _newOwner) external onlyAdmin {
        admin = payable(_newOwner);
    }
    
    
    receive() external payable {}
    
}