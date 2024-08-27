// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract PoolConfiguration {
    uint256 public baseBorrowRate;
    uint256 public optimalSpan;
    uint256 public excessSpan;
    uint256 public optimalUtilizationRate;
    uint256 public collateralRate;
    uint256 public liquidationBonusRate;
    constructor(
        uint256 _baseBorrowRate,
        uint256 _optimalSpan,
        uint256 _exceessSpan,
        uint256 _optimalUtilizationRate,
        uint256 _collateralRate,
        uint256 _liquidationBonusRate
    ) {
        require(
            _optimalUtilizationRate < 1e18,
            "INVALID_OPTIMAL_UTILIZIATION_RAT"
        );
        baseBorrowRate = _baseBorrowRate;
        optimalSpan = _optimalSpan;
        excessSpan = _exceessSpan;
        optimalUtilizationRate = _optimalUtilizationRate;
        collateralRate = _collateralRate;
        liquidationBonusRate = _liquidationBonusRate;
    }
    /**
     * @dev Calculates utilization rate
     * @param _totalBorrows All cummulated borrows in the pool
     * @param _totalLiquidity All available liquidity sittting in the pool and not borrowed
     */
    function getUtilizationRate(
        uint256 _totalBorrows,
        uint256 _totalLiquidity
    ) public pure returns (uint256) {
        return
            _totalLiquidity == 0 ? 0 : (_totalBorrows * 1e18) / _totalLiquidity;
    }
}
