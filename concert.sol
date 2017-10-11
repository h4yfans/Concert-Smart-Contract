pragma solidity ^0.4.17;

contract FunConcert {
 
 address owner;
 uint public tickets;
 uint constant price = 1 ether;
 mapping(address => uint) public purchasers;
 
 function FunConcert(uint t){
     owner = msg.sender;
     tickets = t;
 }
 
   function () payable {
         buyTickets(1);
     }
 
 function buyTickets(uint amount)payable{
     if(msg.value != (amount * price) || amount > tickets){
         revert();
     }
     
     purchasers[msg.sender] += amount;
     tickets -= amount;
    
     if(tickets == 0){
         selfdestruct(owner);
     }
 }
 
 function website() returns (string);
    
 
}

interface Refundable {
    function refund(uint numTickets) returns(bool);
}

contract AbstractFunAttack is FunConcert(10), Refundable {
    
    function refund(uint numTickets) returns(bool){
        if(purchasers[msg.sender] < numTickets){
            return false;
        }
        
        msg.sender.transfer(numTickets * price);
        purchasers[msg.sender] -= numTickets;
        tickets += numTickets;
        return true;
    }
    
    function website() returns (string){
        return "http://karacakaan.com";
    }
}

