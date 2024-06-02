const Web3 = require('web3');
const abi = require('path/to/contract/abi');
const contractAddress = '0x...'; // Address of the deployed contract
const web3 = new Wed3
    ('https://ropsten.infura.io/v3/YOUR_INFURA_API_KEY');
const contrct = new web3.eth.Contract(abi, contractAddress);
// Get the currect greeting
contract.methods.getGreeting().call((error, result) => {
    if (error) {
        console.error(error);
    } else {
        console.log('Current greeting:', result);
    }
});
// Update the greeting
const newGreeting = 'Hello, Solidity!';
contract.methods.setGreeting(newGreeting).send({ from: '0x...' }, (error, transactionHash) => {
    if (error) {
        console.error(error);
    } else {
        console.log('Transaction hash:', transactionHash);
    }
})