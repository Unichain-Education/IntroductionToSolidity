# IntroductionToSolidity

Here we will put the code-samples used for the workshop
The slides of the workshop is available at:
<a>https://docs.google.com/presentation/d/1tbqDZG-_m8Or02McL3tENg4nlE1-G0hMOKRLxItUoDY/edit?usp=sharing</a>

<h2>ERC_20.sol</h2>
ERC_20 is a standard for implementing "fungible" tokens on the Ethereum Platform. To be a true ERC_20 token, one have to implement the agreed set of actions as defined by the ERC20Interface. <br>
To work around overflows we will be using the SafeMath library to perform calculations. SafeMath will ensure that only non-overflowing actions are allowed. If an action would lead to an overflow it will be reverted.


<h2>How to actually use this?</h2>
The commands down here will be executed from a Terminal/CMD open in the directory of the chain.

## Create a new chain
geth --datadir ./blockchain1 init ./genesis.json


## Start the geth console
geth --datadir ./blockchain1 --networkid 2018 --port 30303 --ipcdisable console 2>> myEth.log

## Create user
personal.newAccount("<Password>");

## Login to user, eth.coinbase is the primary address
personal.unlockAccount(eth.coinbase,"somePass", 0);




## To start later on
geth --datadir ./blockchain1 --networkid 2018 --port 30303 --ipcdisable console 2>> myEth.log
personal.unlockAccount(eth.coinbase,"somePass", 0);
