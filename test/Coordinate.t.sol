// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Coordinate, CoordinateStruct} from "../contracts/tables/Coordinate.sol";
import {Store} from "../contracts/core/Store.sol";

contract CoordinateTest is Test, Store {
  address alice = vm.addr(1);
  address bob = vm.addr(2);
  address carol = vm.addr(3);
  address david = vm.addr(4);

  function setUp() public {
    vm.label(alice, "alice");
    vm.label(bob, "bob");
    vm.label(carol, "carol");
    vm.label(david, "david");
  }

  function test_set_Success() public {
    CoordinateStruct memory coord = CoordinateStruct(1, 2, 3);
    Coordinate.setCoordinate(coord);
    assertEq(Coordinate.getCoordinate().x, 1);
    assertEq(Coordinate.getCoordinate().y, 2);
    assertEq(Coordinate.getCoordinate().z, 3);
  }
}
