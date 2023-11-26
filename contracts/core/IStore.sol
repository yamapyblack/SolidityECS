// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IStore {
  function setConfig(bytes32 key, bytes32 value) external;

  function getConfig(bytes32 key) external view returns (bytes32);

  function setConfigString(bytes32 key, string memory value) external;

  function getConfigString(bytes32 key) external view returns (string memory);

  function setRecord(bytes32 tableId, bytes32 key, bytes32 value) external;

  function getRecord(bytes32 tableId, bytes32 key) external view returns (bytes32);

  function setRecordString(bytes32 tableId, bytes32 key, string memory value) external;

  function getRecordString(bytes32 tableId, bytes32 key) external view returns (string memory);
}
