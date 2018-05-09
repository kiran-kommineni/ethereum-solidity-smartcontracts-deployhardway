pragma solidity ^0.4.17;


contract AmountOwed{
    modifier validate(uint amt){
        require(msg.value >= amt);
        _;
    }
}

contract Vehicle2 is AmountOwed{
    enum Deal { Open, Closed }

    uint _flag;
    uint _vin;
    uint _cost;
    address _owner;
    Deal _status;

    event Bought(uint vin, uint cost);

    constructor (uint vin, uint cost, address buyer) public{
        _flag = 0;
        _vin = vin;
        _cost = cost;
        _owner = buyer;
        _status = Deal.Open;
    }

    function getFlag() public view returns(uint){
        return _flag;
    }

    function getVin() public view returns(uint){
        return _vin;        
    }

    function getCost() public view returns(uint){
        return _cost;
    }

    function getOwner() public view returns(address){
        return _owner;
    }

    function buyVehicle() public payable validate(_cost){
        _flag = 1;        
        if(msg.sender == _owner){
            _flag = 2;
            _status = Deal.Closed;
           emit Bought(_vin, _cost);
        }
    }

}