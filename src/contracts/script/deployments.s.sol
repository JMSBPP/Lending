import {Script} from "../lib/forge-std/src/Script.sol";
import "../comet/contracts/CometConfiguration.sol";
import "../comet/contracts/CometCore.sol";
import "../comet/contracts/CometExt.sol";
import "../comet/contracts/CometMath.sol";
import "../comet/contracts/CometRewards.sol";
import "../comet/contracts/CometStorage.sol";
import "../comet/contracts/Comet.sol";
import "../comet/contracts/CometMainInterface.sol";

contract deployments is Script, CometCore {
    //base token is DAI

    bytes32 name = bytes32(abi.encodePacked("cDAI"));
    bytes32 symbol = bytes32(abi.encodePacked("DAI"));

    ExtConfiguration extConfiguration =
        ExtConfiguration({name32: name, symbol32: symbol});

    bool stateExtDeployed = false;

    uint256 DEPLOYER_PRIVATE_KEY = vm.envUint("PRIVATE_KEY");

    //governor, pauseGuardian
    address DEPLOYER_ADDRESS = vm.envAddress("ADDRESS");

    //DAI--baseTokenAddress
    address baseToken = 0x9bc8388dD439fa3365B1F78A81242aDBB4677759;
    //DAI/USD --priceFeed
    address baseTokenPriceFeed = 0xb113F5A928BCfF189C998ab20d753a47F9dE5A61;
    //extensionDelegate
    address cometExtAddress = vm.envAddress("COMET_EXT_ADDRESS");
    //supplyKink
    uint256 public supplyKink = 90 * FACTOR_SCALE;
    //supplyInterestRateSlopeLow
    uint64 supplyPerYearInterestRateSlopeLow = 74999999975328000;
    //supplyInterestRateSlopeHigh
    uint64 supplyPerYearInterestRateSlopeHigh = 3599999999982576000;
    //supplyInterestRateBase
    uint64 supplyPerYearInterestRateBase = 0;
    //borrowKink
    uint256 private borrowKink = 90 * FACTOR_SCALE;
    //borrowPerYearInterestRateSlopeLow
    uint64 borrowPerYearInterestRateSlopeLow = 83299999992192000;
    //borrowPerYearInterestRateSlopeHigh
    uint64 borrowPerYearInterestRateSlopeHigh = 4299999999994080000;
    //borrowPerYearInterestRateBase
    uint64 borrowPerYearInterestRateBase = 14999999976144000;
    //storeFrontPriceFactor
    uint64 storeFrontPriceFactor = 600000000000000000;
    //trackingIndexScale
    uint64 trackingIndexScale = 1 * FACTOR_SCALE;
    //baseTrackingSupplySpeed
    uint64 baseTrackingSupplySpeed = 1747685185185;
    //baseTrackingBorrowSpeed
    uint64 baseTrackingBorrowSpeed = 821759259259;
    //baseMinForRewards
    uint104 baseMinForRewards = 1e12;
    //baseBorrowMin
    uint104 baseBorrowMin = 100000000;
    //targetReserves
    uint104 targetReserves = 20000000000000;
    //assetConfigs
    // 1. [WBTC, priceFeedBTC, DECIMALS, 0.7,0.77,0.05,0 ]
    // 2. [ETH, priceFeedETH, DECIMALS, 0.83, 0.9, 0.05, 0]
    //3. [LINK, priceFeedLINK, DECIMALS, 0.79, 0.85, 0.07, 0]
    //4. [CMP, priceFeedCMP, DECIMALS, 0.65, 0.7,0.12]
    //5. [UNI, priceFeedUNI, DECIMALS, 0.75, 0.81, 0.07, 0]
    AssetConfig WBTC =
        AssetConfig({
            asset: 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
            priceFeed: 0x56a43EB56Da12C0dc1D972ACb089c06a5dEF8e69;
            decimals: DECIMALS;
            borrowCollateralFactor: 70*FACTOR_SCALE;
            liquidateCollateralFactor: 77*FACTOR_SCALE;
            liquidationFactor: 5*FACTOR_SCALE;
            supplyCap: 0;
        });
    AssetConfig LINK=AssetConfig({
        asset: 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
        priceFeed:0x0FB99723Aee6f420beAD13e6bBB79b7E6F034298;
        decimals: DECIMALS;
        borrowCollateralFactor: 79*FACTOR_SCALE;
        liquidateCollateralFactor: 85*FACTOR_SCALE;
        liquidationFactor: 7*FACTOR_SCALE;
        supplyCap: 0;
    });

    Configuration initailConfig = Configuration({governor:DEPLOYER_ADDRESS;pauseGuardian: DEPLOYER_ADDRESS; });

    function run() external {
        if (!stateExtDeployed) {
            vm.startBroadcast(DEPLOYER_PRIVATE_KEY);

            CometExt extContract = new CometExt(extConfiguration);

            vm.stopBroadcast();

            stateExtDeployed = true;
        } else {}

        //The extContract represents an rebasing
        //--ERC-20 token
        //--Token represents VP(principal)(DAI)
        //--Having it in a token makes the
        // Value transferable
    }
}
