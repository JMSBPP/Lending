import {Test} from "../lib/forge-std/src/Test.sol";

contract TestParams is Test {
    function testGetTokenExtParams() external returns (bytes32, bytes32) {
        bytes32 name = bytes32(abi.encode("cDAI"));
        bytes32 symbol = bytes32(abi.encode("DAI"));
        return (name, symbol);
    }
}
