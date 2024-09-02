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
     * @dev Calculates the utilization rate given the totalBorrows and totalLiquidity
     * @param totalBorrows All borrowws in a given token pool
     * @param totalLiquidity Cummulated liquidity in a given token pool
     */
    function getUtilizationRate(
        uint totalBorrows,
        uint totalLiquidity
    ) public pure returns (uint) {
        return totalLiquidity == 0 ? 0 : (totalBorrows * 1e18) / totalLiquidity;
    }

    /**
     * @dev Calculates the borrow interest rate according to the AAVE interest model
     * @param totalBorrows All borrowws in a given token pool
     * @param totalLiquidity Cummulated liquidity in a given token pool
     */
    function calculateBorrowInterestRate(
        uint totalBorrows,
        uint totalLiquidity
    ) public view returns (uint) {
        uint utilizationRate = getUtilizationRate(totalBorrows, totalLiquidity);
        if (utilizationRate > optimalUtilizationRate) {
            return
                baseBorrowRate +
                optimalSpan +
                ((excessSpan * (utilizationRate - optimalUtilizationRate)) /
                    (1e18 - optimalUtilizationRate));
        } else
            return
                baseBorrowRate +
                optimalSpan *
                (utilizationRate / optimalUtilizationRate);
    }
}
