// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "solady/tokens/ERC721.sol";

abstract contract SoulIdentity is ERC721 {
    /// @dev returns the tokenURI for a given tokenID
    mapping (uint256 => string) private _tokenURIs;
    /// @dev returns the name of the Protocol using this SoulIdentity

    /// @dev Returns the token collection name.
    function name() public view virtual override returns (string memory);

    /// @dev Returns the token collection symbol.
    function symbol() public view virtual override returns (string memory);

    /// @dev Returns the Uniform Resource Identifier (URI) for token `id`.
    function tokenURI(
        uint256 id
    ) public view virtual override returns (string memory);

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
