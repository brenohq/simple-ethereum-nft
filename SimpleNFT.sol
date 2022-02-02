// SPDX-License-Identifier: GNU

pragma solidity ^0.8.4;

contract SimpleNFT {
    address public minter;

    // Mappings
    // tokenId => address
    mapping(uint256 => address) public tokenOwner;

    // address => total of NFT's
    mapping(address => uint256) public ownedTokensBalance;

    constructor() {
        minter = msg.sender;
    }

    function _exists(uint256 tokenId) public view returns (bool) {
        address owner = tokenOwner[tokenId];
        return owner != address(0);
    }

    function mint(uint256 tokenId) public {
        require(!_exists(tokenId), "ERROR: Token already exists.");
        require(msg.sender == minter, "ERROR: Sender doesn't match the minter.");

        tokenOwner[tokenId] = msg.sender;
        ownedTokensBalance[msg.sender] += 1;
    }
}
