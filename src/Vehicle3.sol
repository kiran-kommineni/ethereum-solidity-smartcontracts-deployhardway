pragma solidity ^0.4.17;

import "./DmvRegister.sol";
import "./AmountOwed2.sol";


contract Vehicle3 is AmountOwed2 {

    enum DealStatus { Open, Closed }

    uint _vin;
    uint _cost;
    uint _fees;
    address _buyer;
    address _dealer;
    DealStatus _status;
    IDmvRegister _dmvif;

    event BoughtEvt(uint flag, uint vin, uint value, address buyer);

    constructor (uint vin, uint cost, uint fees, address buyer, address dmvcon) public {
        _vin = vin;
        _cost = cost;
        _fees = fees;
        _buyer = buyer;
        _dealer = msg.sender;
        _status = DealStatus.Open;
        _dmvif = IDmvRegister(dmvcon);
        emit BoughtEvt(0, _vin, 0, _buyer);
    }

    function getVin() public view returns (uint) {
        return _vin;
    }
    
    function getCost() public view returns (uint) {
        return _cost;
    }
    
    function getOwner() public view returns (address) {
        return _buyer;
    }
    
    function getDealer() public view returns (address) {
        return _dealer;
    }
    
    function getStatus() public view returns (DealStatus) {
        return _status;
    }

    function buyVehicle() public payable validateAmount(_cost+_fees, _dealer){
        uint _gas = 1000000;
        uint _amt = msg.value;

        if(msg.sender == _buyer){
            emit BoughtEvt(1, _vin, _amt, _buyer);
            _status = DealStatus.Closed;
            _dealer.transfer(_cost);
            _amt = _amt - _cost;
            emit BoughtEvt(2, _vin, _amt, _buyer);
            _dmvif.registerVehicle.value(_amt).gas(_gas)(_vin, _buyer);
            _amt = _amt - _fees;
            emit BoughtEvt(3, _vin, _amt, _buyer);
        }else{
            emit BoughtEvt(4, _vin, msg.value, _buyer);
        }
    }
}