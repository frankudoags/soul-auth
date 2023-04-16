// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC721Metadata} from "./IERC721.sol";

interface ISoul721 is IERC721Metadata {
    error SoulCannotBeTransferred();
    error SoulDoesNotExist();
    
    /// @notice Gets the owner of the soul with the given ID
    /// @param soulId The ID of the soul to check
    /// @return The owner of the soul
    function soulOwner(uint256 soulId) external view returns (address);

    /// @notice Returns the total number of souls
    /// @return The total number of souls
    function allSouls() external view returns (uint256);

    /// @notice Checks whether a soul with the given ID exists
    /// @param soulId The ID of the soul to check
    /// @return Whether the soul exists
    function soulExists(uint256 soulId) external view returns (bool);
}
