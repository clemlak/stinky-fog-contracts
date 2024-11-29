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

contract Core {
    Kontract[] public kontracts;

    function create(address creator, address worker, address escrow, address currency, uint256 amount, uint256 deadline)
        external
        returns (uint256 id)
    {
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

        return kontracts.length;
    }

    function getKontract(uint256 kontractId) external view returns (Kontract memory) {
        return kontracts[kontractId];
    }
}
