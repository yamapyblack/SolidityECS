// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Counter: {
//   keySchema: {},
//   valueSchema: {
//     counter: "uint32",
//   }
// },

import {IStore} from "../core/IStore.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Counter")));
bytes32 constant CounterTableId = _tableId;

library Counter {
  function getCounter() internal view returns (uint32 value_) {
    value_ = uint32(uint(IStore(address(this)).getConfig(_tableId)));
  }

  function setCounter(uint32 _value) internal {
    IStore(address(this)).setConfig(_tableId, bytes32(uint(_value)));
  }
}
