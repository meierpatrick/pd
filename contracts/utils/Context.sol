// Developer: Patrick Developes
// Description: Updated Context
// Tools: Solidity and Truffle
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal virtual view returns (address) {
        return msg.sender;
    }

    function _msgData() internal virtual view returns (bytes calldata) {
        return msg.data;
    }
}
