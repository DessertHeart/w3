// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Vault is ERC20, Ownable {
    constructor() ERC20("Dessert", "DET") {}

    event Deposit(string _log, address indexed _from, uint256 _amount);
    event Withdraw(string _log, address indexed _to, uint256 _amount);

    mapping(address => uint256) userAccount;
    
    // 动态增发
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // 存入合约
    function deposit(address _from, uint256 _amount) external {
        require(msg.sender == _from, "No Trick");
        super.transferFrom(_from, address(this), _amount);
        userAccount[_from] += _amount;

        emit Deposit("Deposit:", _from, _amount);
    }

    // 用户提款
    function withdraw(address _to, uint256 _amount) external {
        require(msg.sender == _to, "No Trick");
        super._transfer(address(this), _to, _amount);
        userAccount[_to] -= _amount;

        emit Withdraw("Withdraw:", _to, _amount);
    }

    // 获得用户存款金额
    function getAccount(address _from) external view returns(uint256){
        return userAccount[_from];
    }

}
