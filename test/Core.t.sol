// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { Core } from "src/Core.sol";

contract CoreTest is Test {
    Core public core;

    function setUp() public {
        core = new Core();
    }
}
