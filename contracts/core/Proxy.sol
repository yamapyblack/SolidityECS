// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";

error FunctionNotFound(bytes4 functionSelector);

abstract contract Proxy {
  /**
   * @notice Raised when the World is calling itself via an external call.
   * @param functionSelector The function selector of the disallowed callback.
   */
  error World_CallbackNotAllowed(bytes4 functionSelector);

  /**
   * @dev Prevents the World contract from calling itself.
   */
  modifier requireNoCallback() {
    if (msg.sender == address(this)) {
      revert World_CallbackNotAllowed(msg.sig);
    }
    _;
  }

  //function selector to system address
  mapping(bytes4 => address) functions;

  function setFunctions(bytes4 _finctionSelectp, address _system) public {
    functions[_finctionSelectp] = _system;
  }

  function getFunctions(bytes4 _finctionSelectp) public view returns (address) {
    return functions[_finctionSelectp];
  }

  /**
   * @notice Accepts ETH and adds to the root namespace's balance.
   */
  receive() external payable {}

  // Find facet for function that is called and execute the
  // function if a facet is found and return any value.
  fallback() external payable requireNoCallback {
    // get facet from function selector
    address system = getFunctions(msg.sig);
    console.logBytes4(msg.sig);
    if (system == address(0)) {
      revert FunctionNotFound(msg.sig);
    }

    // Execute external function from facet using delegatecall and return any value.
    assembly {
      // copy function selector and any arguments
      calldatacopy(0, 0, calldatasize())
      // execute function call using the facet
      let result := delegatecall(gas(), system, 0, calldatasize(), 0, 0)
      // get any return value
      returndatacopy(0, 0, returndatasize())
      // return any return value or error back to the caller
      switch result
      case 0 {
        revert(0, returndatasize())
      }
      default {
        return(0, returndatasize())
      }
    }
  }
}
