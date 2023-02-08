// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(uint256[] memory data) external pure returns (uint256[] memory) {
        uint256 dataLen = data.length;
        uint256 i;
        uint256 j;
        uint256 a;
        uint256 b;

        for (; i < dataLen;) {
            for (j= i+1; j < dataLen;) {
                (a, b) = (data[i], data[j]);
                if (a > b) {
                    (data[j], data[i]) = (a, b);
                }
                unchecked { ++j; }
            }
            unchecked { ++i; }
        }
        return data;
    }
}
