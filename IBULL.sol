pragma solidity >=0.6.10;
pragma experimental ABIEncoderV2;
import "./IERC20.sol";
interface IBULL{
    struct user{
        bool whitelist;
        uint256 participationAmount;
        uint256 lastParticipationBlock;
        bool fcFsparticipator;
        uint256 claimDebt;
    }
    function participate(address _user,uint256 _amount) external;
    function claim(address _user) external returns(uint256);
    function tokenShare(address _user) external view returns(uint256);
    function initialize(
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
    ) external returns(bool);
    function whitelistAddress(address[] memory _user) external  returns(bool);
    function removeAddress(address[] memory _user) external  returns(bool);
    function withdraw(IERC20 _token,address payable _recipient,uint256 _amount,bool native) external;
     function setIdoBlock(uint256 _startBlock,uint256 _endBlock,bool fcfsBlock) external;
    function setToken(IERC20 _token,bool rasing) external;
    function setReleaseBlock(uint256 _releaseBlock,uint256 _vestingBlock) external;
    function setFcfs(bool _Fcfs) external;
    function setAllocation(uint256 _allocation,bool _rasing) external;
    function whiteListAllocation() external returns(uint256);
    function userInfo(address _user) external view returns(user memory);
    function idoInfo() external view returns(
    IERC20,
    IERC20,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    uint256,
    bool
        );
    function renounceOwnership() external  ;

    function transferOwnership(address newOwner) external ;
}
    
