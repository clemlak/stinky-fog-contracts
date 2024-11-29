// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

enum Status {
    Open,
    Disputed,
    Closed
}

struct Kontract {
    address creator;
    address worker;
    address escrow;
    address currency;
    uint256 amount;
    uint256 amountPaid;
    uint256 deadline;
    Status status;
}

contract Core {}
