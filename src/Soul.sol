// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ISoul} from "./interfaces/ISoul.sol";
import {Soul721} from "./Soul721.sol";

contract Soul is Soul721, ISoul {
    constructor() Soul721("Soul", "SOUL") {}

    /// @inheritdoc ISoul
    function createSoul() external override returns (uint256 soulId) {
        if (isAlive[msg.sender]) revert SenderAlreadyHasSoul();
        unchecked {
            // overflow is unrealistic
            _totalSupply++;
        }
        soulId = _totalSupply;
        isAlive[msg.sender] = true;
        soulOwner[soulId] = msg.sender;
        _tokenURIs[soulId] = string(abi.encodePacked("https://soul.com/", _toString(soulId)));
        emit SoulCreated(soulId, msg.sender);
    }
    /// @inheritdoc ISoul
    function burnSoul(uint256 soulId) external override {
        if (soulOwner[soulId] != msg.sender) revert SoulNotOwnedBySender();
        delete isAlive[msg.sender];
        delete soulOwner[soulId];
        delete _tokenURIs[soulId];
        emit SoulBurned(soulId, msg.sender);
    }








        /**
     * @dev Converts a uint256 to its ASCII string decimal representation.
     * credit: ERC721A( Chiru Labs: https://github.com/chiru-labs/ERC721A/blob/1843596cf863557fcd3bf0105222a7c29690af5c/contracts/ERC721A.sol#L1050-L1091)
     */
    function _toString(uint256 value) internal pure virtual returns (string memory str) {
        assembly {
            // The maximum value of a uint256 contains 78 digits (1 byte per digit), but
            // we allocate 0xa0 bytes to keep the free memory pointer 32-byte word aligned.
            // We will need 1 word for the trailing zeros padding, 1 word for the length,
            // and 3 words for a maximum of 78 digits. Total: 5 * 0x20 = 0xa0.
            let m := add(mload(0x40), 0xa0)
            // Update the free memory pointer to allocate.
            mstore(0x40, m)
            // Assign the `str` to the end.
            str := sub(m, 0x20)
            // Zeroize the slot after the string.
            mstore(str, 0)

            // Cache the end of the memory to calculate the length later.
            let end := str

            // We write the string from rightmost digit to leftmost digit.
            // The following is essentially a do-while loop that also handles the zero case.
            // prettier-ignore
            for { let temp := value } 1 {} {
                str := sub(str, 1)
                // Write the character to the pointer.
                // The ASCII index of the '0' character is 48.
                mstore8(str, add(48, mod(temp, 10)))
                // Keep dividing `temp` until zero.
                temp := div(temp, 10)
                // prettier-ignore
                if iszero(temp) { break }
            }

            let length := sub(end, str)
            // Move the pointer 32 bytes leftwards to make room for the length.
            str := sub(str, 0x20)
            // Store the length.
            mstore(str, length)
        }
    }
}
