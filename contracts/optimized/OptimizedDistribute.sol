// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    address payable immutable contributor1;
    address payable immutable contributor2;
    address payable immutable contributor3;
    address payable immutable contributor4;
    uint256 private immutable distributeTime;

    constructor(address[4] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);
        distributeTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        require(
            block.timestamp > distributeTime,
            "cannot distribute yet"
        );

        address _contributor1 = contributor1;
        address _contributor2 = contributor2;
        address _contributor3 = contributor3;
        address _contributor4 = contributor4;

        assembly {
            // shr: logical shift right y by x bits. Two positions is like dividing by 4
            // selfbalance: equivalent to balance(address()), but cheaper
            // See https://docs.soliditylang.org/en/v0.8.15/yul.html
            let amount := shr(2, selfbalance())

            // pop: discard value
            // call: call contract at specific address
            // gas: gas still available to execution
            // selfdestruct: end execution, destroy current contract and send funds to address
            // See https://docs.soliditylang.org/en/v0.8.15/yul.html

            pop(call(gas(), _contributor1, amount, 0, 0, 0, 0))
            pop(call(gas(), _contributor2, amount, 0, 0, 0, 0))
            pop(call(gas(), _contributor3, amount, 0, 0, 0, 0))

            // TODO: better understand how the right amount is sent to 4.
            //       Is the the remaining amount?
            selfdestruct(_contributor4)
        }
    }
}
