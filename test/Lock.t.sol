// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Lock} from "../contracts/Lock.sol";

contract LockTest is Test {
    address alice = vm.addr(1);
    address bob = vm.addr(2);
    address carol = vm.addr(3);
    address david = vm.addr(4);
    Lock lock;

    function setUp() public {
        vm.label(alice, "alice");
        vm.label(bob, "bob");
        vm.label(carol, "carol");
        vm.label(david, "david");
        lock = new Lock(block.timestamp + 100);
    }

    function test_constructor_Success() public {
        assertEq(address(lock.owner()), address(this));
    }
}
