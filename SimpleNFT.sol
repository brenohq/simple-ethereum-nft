// SPDX-License-Identifier: GNU

pragma solidity ^0.8.4;

contract SimpleNFT {
    address public minter;

    // Mappings
    // tokenId => address
    mapping(uint256 => address) public tokenOwner;

    // address => total of NFT's
    mapping(address => uint256) public ownedTokensBalance;

    // Events
    event Sent(address from, address to, uint256 tokenId);

    constructor() {
        minter = msg.sender;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = tokenOwner[tokenId];
        return owner != address(0);
    }

    function mint(uint256 tokenId) public {
        require(!_exists(tokenId), "ERROR: Token already exists.");
        require(msg.sender == minter, "ERROR: Sender doesn't match the minter.");

        tokenOwner[tokenId] = msg.sender;
        ownedTokensBalance[msg.sender] += 1;
    }

    function _ownerOf(uint256 tokenId) internal view returns (address) {
        address owner = tokenOwner[tokenId];
        require(owner != address(0), "ERROR: Invalid token.");
        return owner;
    }

    function send(address receiver, uint256 tokenId) public {
        require(_ownerOf(tokenId) == msg.sender, "ERROR: Token's owner must be the sender.");
        require(receiver != address(0), "ERROR: Invalid receiver");

        tokenOwner[tokenId] = receiver;
        ownedTokensBalance[receiver] += 1;
        ownedTokensBalance[msg.sender] -= 1;

        emit Sent(msg.sender, receiver, tokenId);
    }
}
