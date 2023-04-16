// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ISoul721} from "./interfaces/ISoul721.sol";

/// @title Soul721 - A contract that implements the ERC-721 standard
/// @author Frank Udoags
/// @notice We use this contract to implement the ERC-721 standard, which is used to represent the ownership of a soul

abstract contract Soul721 is ISoul721 {
    // Token name
    string private _name;
    // Token symbol
    string private _symbol;
    // Total number of souls
    uint256 public _totalSupply;


    // Mapping to check if an address has a soul
    mapping(address user => bool hasSoul) isAlive;

    // Mapping from soulID to SoulURI
    mapping(uint256 soulId => address owner) public override soulOwner;

    // Mapping from soulID to SoulURI
    mapping(uint256 soulId => string tokenURI) public _tokenURIs;

    
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() external view override returns (string memory) {
        return _name;
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 _tokenId) external view override returns (string memory) {
        if (!soulExists(_tokenId)) revert SoulDoesNotExist();
        return _tokenURIs[_tokenId];
    }

    function allSouls() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) external view override returns (uint256) {
        return isAlive[_owner] ? 1 : 0;
    }

    function ownerOf(uint256 _tokenId) external view override returns (address) {
        if (soulOwner[_tokenId] == address(0)) revert SoulDoesNotExist();
        return soulOwner[_tokenId];
    }

    function soulExists(uint256 soulId) public view returns (bool) {
        return soulOwner[soulId] != address(0);
    }

    function supportsInterface(bytes4 interfaceID) external pure override returns (bool) {
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
    




    
    /// @notice We override the following functions to prevent the transfer of souls
    /// @notice We do this because we want to prevent the transfer of souls,
    /// @notice and we want to make sure that the souls are not transferable
    /// @notice I mean who would want to transfer a soul anyway?
    /// @notice We need these functions to be overriden because they are defined in the ERC-721 standard
    /// @notice and we still would love to use the ERC-721 standard to represent the ownership of a soul

    function safeTransferFrom(address, address, uint256, bytes calldata) external payable override {
        revert SoulCannotBeTransferred();
    }

    function safeTransferFrom(address, address, uint256) external payable override {
        revert SoulCannotBeTransferred();
    }

    function transferFrom(address, address, uint256) external payable override {
        revert SoulCannotBeTransferred();
    }

    function approve(address, uint256) external payable override {
        revert SoulCannotBeTransferred();
    }

    function setApprovalForAll(address, bool) external pure override {
        revert SoulCannotBeTransferred();
    }

    function getApproved(uint256) external pure override returns (address) {
        revert SoulCannotBeTransferred();
    }

    function isApprovedForAll(address, address) external pure override returns (bool) {
        revert SoulCannotBeTransferred();
    }
}

