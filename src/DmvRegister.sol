pragma solidity ^0.4.17;

import "./IDmvRegister.sol";
import "./AmountOwed2.sol";


contract DmvRegister is IDmvRegister, AmountOwed2 {
    struct OwnerLicense{
        bool registered;
        uint license;
        address owner;
    }

    uint _counter;
    uint _fees;
    address _dmv;
    mapping(uint => OwnerLicense) _licenseTbl;

    event RegisteredEvt(uint flag, uint vin, uint license, uint fees, address buyer);

    function getFees() view public returns(uint){
        return _fees;
    }

    function getLicense(uint vin) public view returns (uint){
        return _licenseTbl[vin].license;
    }

    function registerVehicle(uint vin, address buyer) public payable validateAmount(_fees, _dmv){
        var lic = _licenseTbl[vin];

        if(!lic.registered){
            emit RegisteredEvt(1, vin, lic.license, msg.value, buyer);
            lic.owner = buyer;
            lic.license = _counter;
            lic.registered = true;
            _counter++;
            _dmv.transfer(_fees);
            emit RegisteredEvt(2, vin, lic.license, msg.value-_fees, buyer);
        }else{
            emit RegisteredEvt(3, vin, lic.license, msg.value, buyer);
        }
    }

    constructor (uint fees) public {
        _counter = 101;
        _fees = fees;
        _dmv = msg.sender;
        emit RegisteredEvt(0, 0, 0, fees, address(0));
    }







}