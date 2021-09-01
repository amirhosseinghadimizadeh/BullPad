// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10;
pragma experimental ABIEncoderV2;
import "./BullContract.sol";

contract Bullpad is BullIdo{
    function participate(address _user,uint256 _amount) public{
          if(block.number<endBlock){
              _participate(_user,_amount);
          }
          else if(block.number<fcfsEndBlock){
              _fcfsParticipate(_user,_amount);
          }
    }
    function claim(address _user)public returns(uint256){
       return _claimShare(_user);
    }
    function tokenShare(address _user)public view returns(uint256){
        return _userShare(_user);
    }

}