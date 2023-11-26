// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

type ResourceId is bytes32;
error FunctionNotFound(bytes4 functionSelector);

contract Store {
  bytes32 internal constant SLOT = keccak256("mud.store");
  bytes32 internal constant DYNMAIC_DATA_SLOT = keccak256("mud.store.dynamicData");
  bytes32 internal constant DYNAMIC_DATA_LENGTH_SLOT = keccak256("mud.store.dynamicDataLength");

  //function selector to system address
  mapping(bytes4 => address) functions;
  //tableId x columnId => value
  mapping(bytes32 => bytes32) config;
  mapping(bytes32 => string) configString; //more than bytes32
  //tableId x columnId => record => value
  mapping(bytes32 => mapping(bytes32 => bytes32)) record;
  mapping(bytes32 => mapping(bytes32 => string)) recordString; //more than bytes32

  function setFunctions(bytes4 _finctionSelectp, address _system) public {
    functions[_finctionSelectp] = _system;
  }

  function getFunctions(bytes4 _finctionSelectp) public view returns (address) {
    return functions[_finctionSelectp];
  }

  function setConfig(bytes32 key, bytes32 value) public {
    config[key] = value;
  }

  function getConfig(bytes32 key) public view returns (bytes32) {
    return config[key];
  }

  function setConfigString(bytes32 key, string memory value) public {
    configString[key] = value;
  }

  function getConfigString(bytes32 key) public view returns (string memory) {
    return configString[key];
  }

  function setRecord(bytes32 tableId, bytes32 key, bytes32 value) public {
    record[tableId][key] = value;
  }

  function getRecord(bytes32 tableId, bytes32 key) public view returns (bytes32) {
    return record[tableId][key];
  }

  function setRecordString(bytes32 tableId, bytes32 key, string memory value) public {
    recordString[tableId][key] = value;
  }

  function getRecordString(bytes32 tableId, bytes32 key) public view returns (string memory) {
    return recordString[tableId][key];
  }
}
