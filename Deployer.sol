// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10;
pragma experimental ABIEncoderV2;
import "./IBULL.sol";
import "./Ownable.sol";
import "./SafeERC20.sol";
contract bullManager is Ownable{
    using SafeERC20 for IERC20;
    address public masterContract;
    IBULL public idoContract;
    function _deploy(
    ) internal  returns (address cloneAddress) {
        require(masterContract != address(0), "BullPad: No masterContract");
        bytes20 targetBytes = bytes20(masterContract);
        assembly {
            let clone := mload(0x40)
            mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(clone, 0x14), targetBytes)
            mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            cloneAddress := create(0, clone, 0x37)
        }
     }
    function idoDeployment() internal returns(IERC20){
        idoContract = IBULL(_deploy());
    }
     function createIdo(
            IERC20 _offeringToken,
     IERC20 _rasingToken,
     uint256 _totalAllocation,
     uint256 _releseBlock,
     uint256 _vestingBlock,
     uint256 _startBlock,
     uint256 _offeringDuration,
     uint256 _offeringAllocation,
     uint256 _fcfsStartBlock,
     uint256 _fcfsDuration,
     bool _OfferRemainedAllocation
           )public onlyOwner{
            idoDeployment();
            _offeringToken.safeTransferFrom(_msgSender(),address(idoContract),_offeringAllocation);
            idoContract.initialize(
            _offeringToken,
            _rasingToken,
            _totalAllocation,
            _releseBlock,
            _vestingBlock,
            _startBlock,
            _offeringDuration,
            _offeringAllocation,
            _fcfsStartBlock,
            _fcfsDuration,
            _OfferRemainedAllocation);
            idoContract.transferOwnership(_msgSender());
            idoContract = IBULL(0);
           }
    function newMasterContract(address _mastercontract)public onlyOwner{
        masterContract = _mastercontract;
    }
}