// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Proxy} from "../core/Proxy.sol";
import {LevelStruct, Level} from "./tables/Level.sol";

contract World is Proxy {
  //for Level table
  function getLevel() external pure returns (LevelStruct memory) {
    return Level.getLevel();
  }
}
