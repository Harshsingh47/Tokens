// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.9.0;




contract Payable{
    
    event Deposit(address sender, uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    event Transfer(address to, uint amount, uint balance);
    
    address payable public owner;
    
    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }
    
    // Function to deposit Ether into this contract
    // Call this function with some Ether
    function deposit() public payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);    
    }
    
    //Call this function with some Ether 
    // This function will throw error since this is a non payable function
    function notPayable() public{}
    
    // Function to withdraw Ether from this contract
    function withdraw() public {
        // get the amount of ether stored in this contract
        // uint amount = address(this).balance;
        uint amount = 5;
        // Owner can receive Ether since the address of owner is payable
        (bool success,) = owner.call{value: amount}("");
        require(success,"Failed to send Ether");
    }
    
    // function to transfer ether from this contract to address in input
    function transfer(address payable _to, uint _amount) public {
        (bool success,) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
    
    // function to see/get the balance available in the contract
     function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    
}

// ----------------------------------------------------------------------------------------------------
