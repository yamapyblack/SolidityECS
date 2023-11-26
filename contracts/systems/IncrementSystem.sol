// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Counter} from "../tables/Counter.sol";
import "hardhat/console.sol";

contract IncrementSystem {
  function increment() public returns (uint32) {
    uint32 counter = Counter.getCounter();
    uint32 newValue = counter + 1;
    Counter.setCounter(newValue);
    return newValue;
  }
}
