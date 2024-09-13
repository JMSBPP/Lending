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

    bool stateDeployed = false;

    uint256 DEPLOYER_PRIVATE_KEY = vm.envUint("PRIVATE_KEY");
    address DEPLOYER_ADDRESS = vm.envAddress("ADDRESS");

    address cometExtAddress = vm.envAddress("COMET_EXT_ADDRESS");

    uint256 public supplyKink = 93 * FACTOR_SCALE;
    uint256 private borrowKink = 93 * FACTOR_SCALE;

    function run() external {
        if (!stateDeployed) {
            vm.startBroadcast(DEPLOYER_PRIVATE_KEY);

            CometExt extContract = new CometExt(extConfiguration);

            vm.stopBroadcast();

            stateDeployed = true;
        } else {}

        //The extContract represents an rebasing
        //--ERC-20 token
        //--Token represents VP(principal)(DAI)
        //--Having it in a token makes the
        // Value transferable

        //
        // --------config parameters------
        // ==>
        //
        //-------Arbitrum Sepolia deployment----
        //governor My Address
        //pauseGuardian My Address
        //DAI--baseTokenAddress
        //0x9bc8388dD439fa3365B1F78A81242aDBB4677759
        //DAI/USD --priceFeed
        //0xb113F5A928BCfF189C998ab20d753a47F9dE5A61
        //extensionDelegate
        //cometExtAddress
        //supplyKink
    }
}
