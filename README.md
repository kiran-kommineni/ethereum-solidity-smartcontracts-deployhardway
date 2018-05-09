# ethereum-solidity-smartcontracts-deployhardway
The truffle framework masks the time consuming steps needed to deploy solidity smart contracts onto Ethereum network. However, it is essential to know the steps masked by truffle in deploying a smart contract to debug production defects

Steps to deploy your smart contracts manually:

Start a new node
-----------------
mkdir -p ~/.ethereum/conf
mkdir -p ~/.ethereum/data/test

sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum
geth version

Create accounts for transacting
-------------------------------
geth --datadir ~/.ethereum/data/test account new

Acct1 : passphrase: bank
		c9f18a212d6429aba8faa3555ba8f0ff42f1b116

Acct2: passphrase: buyer
	   6a11688f8b9d46f1eb39f8b677df786b0fc9001f

Acct3: passphrase: dealer
       d26c14f3d30ee88d1f11d927d9acdc80cca10944

Acct4: passphrase: dmv
	   adc4d9696fa8879380cfc9a9e07dc3286d5b1510

ls -l data/test/keystore/

geth --datadir ./data/test account list

Create a genesis file in conf folder
-----------------------------------

{
    "config": {
        "chainId": 21,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
    "nonce": "0x0000000000000000",
    "timestamp": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "extraData": "0x00",
    "gasLimit": "0x80000000",
    "difficulty": "0x400",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0xc9f18a212d6429aba8faa3555ba8f0ff42f1b116",
    "alloc": {
        "c9f18a212d6429aba8faa3555ba8f0ff42f1b116": {
            "balance": "20000000000000000000"
        },
        "6a11688f8b9d46f1eb39f8b677df786b0fc9001f": {
            "balance": "10000000000000000000"
        },
        "d26c14f3d30ee88d1f11d927d9acdc80cca10944": {
            "balance": "5000000000000000000"
        },
        "adc4d9696fa8879380cfc9a9e07dc3286d5b1510": {
            "balance": "3000000000000000000"
        }        
    }
}


geth --datadir ./data/test init ./conf/genesis.json

geth --identity "test" --datadir ./data/test --ethash.dagdir ./data/test --networkid "21" --maxpeers 0 --nodiscover --ipcdisable --rpc --rpcaddr 127.0.0.1 --rpcport 8081 --rpccorsdomain "*" --port 30001 --verbosity 2 console7

##############
# Node commands
##############
admin :: used for getting information about and managing the node
debug :: used for debugging purposes
eth :: used for transaction and blockchain level operations
miner :: used for managing mining operation
personal :: used for getting information about and managing accounts
txpool :: used for inspecting the transaction pool

Ex:
admin.nodeInfo
admin.peers
debug.dumpBlock("0x0");
personal.listAccounts();
eth.getBlock(0);

eth.sendTransaction({ from: buyer, to: dealer, value: web3.toWei(1, "ether")} );

"0xed607a6118e894e6377848d647f346a0c55ef6d61ae164290b18cc6701b1002a"

eth.pendingTransactions

txpool.inspect

function showBalances() {
  var i = 0;
  eth.accounts.forEach(function(e) {
     console.log("---> eth.accounts["+i+"]: " + e + " \tbalance: " + web3.fromWei(eth.getBalance(e), "ether") + " ether");
     i++;
  })
};


showBalances();

eth.getTransaction("0xed607a6118e894e6377848d647f346a0c55ef6d61ae164290b18cc6701b1002a");

eth.getBlock("latest");

eth.getTransactionFromBlock(1);

Write a contract Vehicle.sol

solc -o ./bin --abi --bin --gas ./src/Vehicle.sol

echo "var vehicle=`solc --optimize --combined-json abi,bin,interface src/Vehicle.sol`" > bin/Vehicle.js

loadScript("/opt/projects/vechile-registration/bin/Vehicle.js");

vehicle.contracts['src/Vehicle.sol:Vehicle'].abi

vehicle.contracts['src/Vehicle.sol:Vehicle'].bin

buyer = "0x6a11688f8b9d46f1eb39f8b677df786b0fc9001f"

dealer = "0xd26c14f3d30ee88d1f11d927d9acdc80cca10944"

var vehicle_contract = eth.contract(JSON.parse(vehicle.contracts['src/Vehicle.sol:Vehicle'].abi));

var contract_transaction = { from: dealer, data: '0x'+vehicle.contracts['src/Vehicle.sol:Vehicle'].bin, gas: gas_price }

personal.unlockAccount(dealer)

var vehicle_contract_inst = vehicle_contract.new(vin, dealer, contract_transaction)

miner.start(1)

txpool.inspect

miner.stop()

vehicle_contract_inst.transactionHash

eth.getBlock(34);

eth.getCode(eth.getTransactionReceipt(vehicle_contract_inst.transactionHash).contractAddress)

var vehicle_inst = vehicle_contract.at(eth.getTransactionReceipt(vehicle_contract_inst.transactionHash).contractAddress);

vehicle_inst.getOwner.call()
vehicle_inst.getVinNo.call()

loadScript("/opt/projects/vechile-registration/src/UtilScripts3.js");

echo "var dmvregister=`solc --optimize --combined-json abi,bin,interface src/DmvRegister.sol`" > bin/DmvRegister.js

echo "var vehicle3=`solc --optimize --combined-json abi,bin,interface src/Vehicle3.sol`" > bin/Vehicle3.js

loadScript("/opt/projects/vechile-registration/bin/Vehicle3.js");
loadScript("/opt/projects/vechile-registration/bin/DmvRegister.js");
