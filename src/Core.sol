// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {SafeTransferLib} from "@solady/utils/SafeTransferLib.sol";

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

event Create(
    uint256 id,
    address indexed creator,
    address indexed worker,
    address escrow,
    address indexed currency,
    uint256 amount
);

event Pay(uint256 id, address indexed creator, address indexed worker, address indexed currency, uint256 amountPaid);

event Close(uint256 id);

error InvalidActors();

error InvalidAmount();

error InvalidDeadline();

error InvalidMsgValue();

contract Core {
    Kontract[] public kontracts;

    function create(address creator, address worker, address escrow, address currency, uint256 amount, uint256 deadline)
        external
        payable
        returns (uint256 id)
    {
        if (creator == worker || creator == escrow || worker == escrow) revert InvalidActors();

        if (amount == 0) revert InvalidAmount();

        if (block.timestamp > deadline) revert InvalidDeadline();

        kontracts.push(
            Kontract({
                creator: creator,
                worker: worker,
                escrow: escrow,
                currency: currency,
                amount: amount,
                amountPaid: 0,
                deadline: deadline,
                status: Status.Open
            })
        );

        if (currency == address(0) && msg.value != amount) {
            revert InvalidMsgValue();
        } else if (currency != address(0) && msg.value > 0) {
            revert InvalidMsgValue();
        }

        return kontracts.length;
    }

    function getKontract(uint256 kontractId) external view returns (Kontract memory) {
        return kontracts[kontractId];
    }
}
