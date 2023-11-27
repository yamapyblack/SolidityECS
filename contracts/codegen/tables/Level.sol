// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Level: {
//   keySchema: {},
//   valueSchema: {
//     hp: "uint128",
//     mp: "uint128",
//     at: "uint128",
//     skill: "address",
//   }
// },

// import {console2} from "forge-std/Test.sol";

bytes32 constant LevelTableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Level")));

struct LevelStruct {
  uint128 hp;
  uint128 mp;
  uint128 at;
  address skill;
}

library Level {
  function StorageSlot() internal pure returns (LevelStruct storage ds) {
    bytes32 position = LevelTableId;
    assembly {
      ds.slot := position
    }
  }

  function setLevel(LevelStruct memory _value) internal returns (LevelStruct memory) {
    LevelStruct storage levelStorage = StorageSlot();
    levelStorage.hp = _value.hp;
    levelStorage.mp = _value.mp;
    levelStorage.at = _value.at;
    levelStorage.skill = _value.skill;
    return levelStorage;
  }

  function getLevel() internal pure returns (LevelStruct memory) {
    return StorageSlot();
  }
}
