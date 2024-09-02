pragma solidity ^0.8.0;

import {Ownable} from "../dependencies/dependencies/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ERC20} from "../dependencies/dependencies/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IAssetPool} from "./interfaces/IAssetPool.sol";

contract AssetPoolShare is ERC20, Ownable {
    IAssetPool private assetPool;
    ERC20 public underlyingAsset;
    constructor(
        string memory _name,
        string memory _symbol,
        IAssetPool _assetPool,
        ERC20 _underlyingAsset
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        assetPool = _assetPool;
        underlyingAsset = _underlyingAsset;
    }

    function mint(address _account, uint256 _amount) external onlyOwner {
        _mint(_account, _amount);
    }
    function burn(address _account, uint256 _amount) external onlyOwner {
        _burn(_account, _amount);
    }
    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal override {
        super._transfer(_from, _to, _amount);
        require(assetPool.isAccountHealthy(_from), "TRANSFER_NOT_ALLOWED");
    }
}
