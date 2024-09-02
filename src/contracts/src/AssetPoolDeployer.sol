pragma solidity ^0.8.0;

import {ERC20} from "../dependencies/dependencies/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IAssetPool} from "./interfaces/IAssetPool.sol";
import {AssetPoolShare} from "./AssetPoolShare.sol";

contract AssetPoolDeployer {
    function createAssetPoolShare(
        string memory _name,
        string memory _symbol,
        ERC20 _underlyingAsset
    ) public returns (AssetPoolShare) {
        AssetPoolShare shareToken = new AssetPoolShare(
            _name,
            _symbol,
            IAssetPool(msg.sender),
            _underlyingAsset
        );
        shareToken.transferOwnership(msg.sender);
        return shareToken;
    }
}
