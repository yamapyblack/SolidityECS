// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Level, LevelStruct} from "../contracts/codegen/tables/Level.sol";
import {World} from "../contracts/codegen/World.sol";
import {LevelSystem} from "../contracts/systems/LevelSystem.sol";

interface ILevelSystem {
  function setLevel(LevelStruct memory _level) external;

  function getLevel() external view returns (LevelStruct memory);
}

contract LevelSystemTest is Test {
  address alice = vm.addr(1);
  address bob = vm.addr(2);
  address carol = vm.addr(3);
  address david = vm.addr(4);
  World proxy;
  LevelSystem levelSystem;

  function setUp() public {
    vm.label(alice, "alice");
    vm.label(bob, "bob");
    vm.label(carol, "carol");
    vm.label(david, "david");
    proxy = new World();
    levelSystem = new LevelSystem();
    proxy.setFunctions(levelSystem.setLevel.selector, address(levelSystem));
  }

  function test_setLevel_Success() public {
    LevelStruct memory level = LevelStruct(1, 2, 3, address(10));
    ILevelSystem levelProxy = ILevelSystem(address(proxy));
    levelProxy.setLevel(level);
    assertEq(levelProxy.getLevel().hp, 1);
    assertEq(levelProxy.getLevel().mp, 2);
    assertEq(levelProxy.getLevel().at, 3);
    assertEq(levelProxy.getLevel().skill, address(10));
  }
}
