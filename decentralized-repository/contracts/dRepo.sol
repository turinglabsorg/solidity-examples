// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
pragma abicoder v2;

contract dRepo {

    struct Object {
        string metadata;
        string extID;
    }

    mapping(address => Object[]) private items;
    address[] private owners;

    function getOwners() public view returns(address[] memory) {
        return owners;
    }

    function getRepository(address addr) public view returns(Object[] memory) {
        return items[addr];
    }

    function exists(address addr) internal view returns (bool) {
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == addr) {
                return true;
            }
        }
        return false;
    }

    function remove(uint256 index) public returns (bool) {
        require(exists(msg.sender), 'User never added items in repository.');
        Object[] memory old = items[msg.sender];
        delete items[msg.sender];
        for (uint i = 0; i < old.length; i++) {
            if (i != index) {
                items[msg.sender].push(old[i]);
            }
        }
        return true;
    }

    function add(string memory metadata, string memory extID) public {
        bool itemExists = false;
        for (uint i = 0; i < items[msg.sender].length; i++) {
            if (keccak256(abi.encodePacked(items[msg.sender][i].metadata)) == keccak256(abi.encodePacked(metadata))) {
                itemExists = true;
            }
        }
        require(!itemExists, 'This metadata exists in repository.');
        items[msg.sender].push(Object(metadata, extID));
        if(!exists(msg.sender)){
            owners.push(msg.sender);
        }
    }

    function get(address addr, string memory extID) public view returns (Object memory) {
        for (uint i = 0; i < items[addr].length; i++) {
            if (keccak256(abi.encodePacked(items[addr][i].extID)) == keccak256(abi.encodePacked(extID))) {
                return items[addr][i];
            }
        }
    }
}