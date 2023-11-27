// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Level, LevelStruct} from "../codegen/tables/Level.sol";
import "hardhat/console.sol";

contract LevelSystem {
  function setLevel(LevelStruct memory _level) public {
    Level.setLevel(_level);
  }
}
