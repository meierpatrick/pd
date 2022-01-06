// Developer: Patrick Developes
// Description: Updated Smart Contract
// Tools: Solidity and Truffle
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./utils/Interface.sol";
import "./utils/SafeMath.sol";
import "./utils/Ownable.sol";

contract palestinianDinar is IBEP20, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public _balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    uint256 private _totalSupply;
    uint8 private _decimals;
    string private _symbol;
    string private _name;

    constructor() {
        _name = "Palestinian Dinar";
        _symbol = "PD";
        _decimals = 8;
        _totalSupply = 161803398874900000000;
        _balances[msg.sender] = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function getOwner() public view returns (address) {
        return owner();
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "BEP20 or as ERC20: transfer from the zero address");
        require(recipient != address(0), "BEP20 or as ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(
            amount,
            "BEP20 or as ERC20: transfer amount exceeds balance"
        );
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "BEP20 or as ERC20: approve from the zero address");
        require(spender != address(0), "BEP20 or as ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "BEP20 or as ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }
}
