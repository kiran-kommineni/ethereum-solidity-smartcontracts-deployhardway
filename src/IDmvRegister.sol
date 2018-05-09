pragma solidity ^0.4.17;

contract IDmvRegister{

    function getFees() public view returns (uint);
    function getLicense(uint vin) public view returns (uint);
    function registerVehicle(uint vin, address buyer)public payable;
}