# IntroductionToSolidity

Here we will put the code-samples used for the workshop

<h2>ERC_20.sol</h2>
ERC_20 is a standard for implementing "fungible" tokens on the Ethereum Platform. To be a true ERC_20 token, one have to implement the agreed set of actions as defined by the ERC20Interface. <br>
To work around overflows we will be using the SafeMath library to perform calculations. SafeMath will ensure that only non-overflowing actions are allowed. If an action would lead to an overflow it will be reverted.


