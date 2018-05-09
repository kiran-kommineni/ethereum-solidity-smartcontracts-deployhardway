var bank = "0xc9f18a212d6429aba8faa3555ba8f0ff42f1b116";
var buyer = "0x6a11688f8b9d46f1eb39f8b677df786b0fc9001f";
var dealer = "0xd26c14f3d30ee88d1f11d927d9acdc80cca10944";
var dmv = "0xadc4d9696fa8879380cfc9a9e07dc3286d5b1510";

var vin = 9701988921;
var cost = 4000000000000000000;
var fees = 1000000000000000000;
var gas  = 1000000;
var total = 5000000000000000000;

function showBalances() {
  var i = 0;
  eth.accounts.forEach(function(e) {
     console.log("---> eth.accounts["+i+"]: " + e + " \tbalance: " + web3.fromWei(eth.getBalance(e), "ether") + " ether");
     i++;
  })
};