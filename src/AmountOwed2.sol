pragma solidity ^0.4.17;

contract AmountOwed2 {

    event AmountEvt(uint flag, uint value, uint amount, address context);

    modifier validateAmount(uint amt, address context){
        emit AmountEvt(1, msg.value, amt, context);
        require(msg.value >= amt);
        emit AmountEvt(2, msg.value, amt, context);
        _;
        emit AmountEvt(3, msg.value, amt, context);
    }

}