// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Coordinate: {
//   keySchema: {},
//   valueSchema: {
//     x: "uint32",
//     y: "uint32",
//     z: "uint32",
//   }
// },

import {IStore} from "../core/IStore.sol";
import {console2} from "forge-std/Test.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Coordinate")));
bytes32 constant CoordinateTableId = _tableId;

struct CoordinateStruct {
  uint32 x;
  uint32 y;
  uint32 z;
}

library Coordinate {
  function toBytes32(uint32 x, uint32 y, uint32 z) public pure returns (bytes32 result) {
    assembly {
      mstore(0x20, shl(224, x)) // shift left 224 bits, because 1 word is 256 bits and uint32 is 32 bits
      mstore(0x24, shl(224, y)) // store y after x
      mstore(0x28, shl(224, z)) // store z after y
      result := mload(0x20) // load the combined 96 bits into a bytes32
    }
  }

  function fromBytes32(bytes32 b) public view returns (uint32 x, uint32 y, uint32 z) {
    assembly {
      x := shr(224, b)
      y := shr(192, b)
      z := shr(160, b)
    }
  }

  function getCoordinate() internal view returns (CoordinateStruct memory value_) {
    bytes32 _value = IStore(address(this)).getConfig(_tableId);
    console2.logBytes32(_value);
    (value_.x, value_.y, value_.z) = fromBytes32(_value);
  }

  function setCoordinate(CoordinateStruct memory _value) internal {
    IStore(address(this)).setConfig(_tableId, toBytes32(_value.x, _value.y, _value.z));
    console2.logBytes32(toBytes32(_value.x, _value.y, _value.z));
  }
}
