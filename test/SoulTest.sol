// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Soul} from "../src/Soul.sol";
import {ISoul} from "../src/interfaces/ISoul.sol";

contract SoulTest is Test, ISoul {
    Soul public soul;
    address public owner = address(0x123);
    address public alice = address(0x456);
    address public bob = address(0x789);

    function setUp() public {
        soul = new Soul();
    }

    function testSoulCreation() public {
        assertEq(soul.allSouls(), 0);
        assertEq(soul.name(), "Soul");
        assertEq(soul.symbol(), "SOUL");
        // create a soul, and check that the owner has a soul
        vm.prank(owner);
        soul.createSoul();
        assertEq(soul.allSouls(), 1);
        assertEq(soul.balanceOf(owner), 1);
        assertEq(soul.tokenURI(1), "https://soul.com/1");
        // try to create another soul, and check that the owner cannot have two souls
        vm.prank(owner);
        vm.expectRevert(SenderAlreadyHasSoul.selector);
        soul.createSoul();
        // cannot burn a soul you don't own
        vm.prank(alice);
        vm.expectRevert(SoulNotOwnedBySender.selector);
        soul.burnSoul(1);

    }






























    function createSoul() external override returns (uint256 soulId) {}

    function burnSoul(uint256 soulId) external override {}
}
