pragma solidity ^0.4.17;

contract Vehicle{

    uint public vin_no;
    address public owner;

    constructor (uint vin, address dealer)public {
        vin_no = vin;
        owner = dealer;
    }

    function getVinNo() public view returns(uint){
        return vin_no;
    }

    function getOwner() public view returns(address){
        return owner;
    }

    function soldTo(address buyer) public {
        if(msg.sender == owner){
            owner = buyer;
        }
    }


}