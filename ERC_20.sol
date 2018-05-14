pragma solidity ^0.4.23;

contract Owned {
	address public owner;
	address public newOwner;

	event OwnershipTransferred(address indexed _from, address indexed _to);
		
	constructor() public {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
 
	function transferOwnership(address _newOwner) public onlyOwner {
		newOwner = _newOwner;
	}

	function acceptOwnership() public {
		require(msg.sender == newOwner);
		owner = newOwner;
		newOwner = address(0);
		emit OwnershipTransferred(owner, newOwner);
	}
}

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address _owner) public constant returns (uint balance);
    function allowance(address _owner, address _spender) public constant returns (uint remaining);
    function transfer(address _to, uint _amount) public returns (bool success);
    function approve(address _spender, uint _amount) public returns (bool success);
    function transferFrom(address _from, address _to, uint _amount) public returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint _amount);
    event Approval(address indexed _tokenOwner, address indexed _spender, uint _amount);
}

contract ERC20Abstract is ERC20Interface, Owned{
	using SafeMath for uint;

	uint public supply;
	uint8 public decimals;

	string public name;
	string public symbol;

	mapping(address => uint256) balances;
	mapping(address => mapping(address => uint256)) allowed;

	function balanceOf(address _owner) public view returns(uint balance){
		return balances[_owner];
	}

	function allowance(address _from, address _to) public view returns(uint){
		return allowed[_from][_to];
	}

	function totalSupply() public view returns(uint){
		return supply - balances[address(0)];
	}

	function transfer(address _to, uint _amount) public returns (bool){
		balances[msg.sender] = balances[msg.sender].sub(_amount);
		balances[_to] = balances[_to].add(_amount);
		emit Transfer(msg.sender, _to, _amount);
		return true;
	}

	function approve(address _spender, uint _amount) public returns(bool){
		allowed[msg.sender][_spender] = _amount;
		emit Approval(msg.sender, _spender, _amount);
		return true;
	}

	function transferFrom(address _from, address _to, uint _amount) public returns(bool){
		allowed[_from][msg.sender] =allowed[_from][msg.sender].sub(_amount);
		balances[_from] = balances[_from].sub(_amount);
		balances[_to] = balances[_to].add(_amount);
		emit Transfer(_from, _to, _amount);
		return true;
	}

	function () public payable{
		revert();
	}

}

contract JACoin_NoMint is ERC20Abstract {

	constructor(string _name, string _symbol, uint _supply, uint8 _decimals) public{
		name = _name;
		symbol = _symbol;
		supply = _supply;
		decimals = _decimals;
		balances[msg.sender] = balances[msg.sender].add(_supply);
	}

}

contract JACoin_Mint is ERC20Abstract{

	event Mint(address indexed _to, uint _amount);

	constructor(string _name, string _symbol, uint _supply, uint8 _decimals) public{
		name = _name;
		symbol = _symbol;
		supply = _supply;
		decimals = _decimals;
		balances[msg.sender] = balances[msg.sender].add(_supply);
	}

	function mint(address _to, uint _amount) onlyOwner public returns(bool){
		supply = supply.add(_amount);
		balances[_to] = balances[_to].add(_amount);
		emit Mint(_to, _amount);
		return true;
	}

}
