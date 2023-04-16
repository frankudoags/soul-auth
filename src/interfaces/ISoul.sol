// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ISoul {
    error SoulAlreadyExists();
    error SoulNotOwnedBySender();
    error SenderAlreadyHasSoul();

    event SoulCreated(uint256 indexed soulId, address indexed owner);
    event SoulBurned(uint256 indexed soulId, address indexed owner);

    /// @notice Creates a new soul and assigns it to the owner
    /// @return soulId The ID of the soul minted to the owner
    /// Aha, you are a soul, you are a soul, you are a soul, you are a soul
    function createSoul() external returns (uint256 soulId);

    /// @notice the soul must exist and be owned by the caller
    /// @dev Burns a soul
    /// @param soulId The ID of the soul to burn
    /// We really hate to see you go, but we love to watch you leave
    function burnSoul(uint256 soulId) external;
}
