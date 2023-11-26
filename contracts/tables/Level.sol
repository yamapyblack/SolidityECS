// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Level: {
//   keySchema: {},
//   valueSchema: {
//     hp: "uint128",
//     mp: "uint128",
//     at: "uint256",
//     skill: "address",
//   }
// },

import {console2} from "forge-std/Test.sol";

bytes32 constant LevelTableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Level")));

struct LevelStruct {
  uint128 hp;
  uint128 mp;
  uint256 at;
  address skill;
}

library Level {
  function StorageSlot() internal pure returns (LevelStruct storage ds) {
    bytes32 position = LevelTableId;
    assembly {
      ds.slot := position
    }
  }

  function getLevel() internal view returns (LevelStruct memory) {
    return StorageSlot();
  }

  function setLevel(LevelStruct memory _value) internal {
    LevelStruct storage testState = StorageSlot();
    testState.hp = _value.hp;
    testState.mp = _value.mp;
    testState.at = _value.at;
    testState.skill = _value.skill;
  }
}
