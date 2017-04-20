/// math.sol -- mixin for inline numerical wizardry

// Copyright (C) 2015, 2016, 2017  Nexus Development, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.10;

contract OverflowProtectable {
    // ensure that the result of adding x and y is valid 
    function safeAdd(uint128 x, uint128 y) constant returns (uint128 z) {
        assert( (z = x + y) >= x);
    }
 
    // ensure that the result of subtracting x and y is valid 
    function safeSub(uint128 x, uint128 y) constant returns (uint128 z) {
        assert( (z = x - y) <= x);
    }

    // ensure that the resulting integer is 128 bits
    function ensure128Bit(uint256 x) constant returns (uint128 z) {
        assert( (z = uint128(x)) == x);
    }

    uint128 constant BP18 = 10 ** 18;  // scales token balance to precision of 18 digits
    uint128 constant BP36 = 10 ** 36;  // scales token balance to precision of 36 digits

    function safeBP18Mult(uint128 x, uint128 y) constant returns (uint128 z) {
        // x*y + 500000000000000000
        // -------------------------
        //      1000000000000000000
        z = ensure128Bit(( (uint256(x) * y) + (BP18 / 2) ) / BP18);
    }
    function safeBP18Div(uint128 x, uint128 y) constant returns (uint128 z) {
        //  x * 500000000000000000 + y/2
        //  ----------------------------
        //               y
        z = ensure128Bit(( (uint256(x) * BP18) + (y / 2) ) / y);
    }
    
    function safeBP36Mult(uint128 x, uint128 y) constant returns (uint128 z) {
        //  x*y + 500000000000000000000000000000000000
        //  ------------------------------------------
        //       1000000000000000000000000000000000000
        z = ensure128Bit(( (uint256(x) * y) + (BP36 / 2) ) / BP36);
    }

    function safeBP36Div(uint128 x, uint128 y) constant returns (uint128 z) {
        z = ensure128Bit(( (uint256(x) * BP36) + (y / 2) ) / y);
    }

    function safeBP36Power(uint128 x, uint64 n) constant returns (uint128 z) {
        // if n / 2 doesn't yield a remainder of 0, 
        // z = x, 
        // else, 
        // z = 10**36
        z = n % 2 != 0 ? x : BP36;
        // n = n / 2; while n isn't 0, n = n / 2
        for (n /= 2; n != 0; n /= 2) {
            x = safeBP36Mult(x, x);
            // if n / 2 doesn't yield a remainder of 0, 
            if (n % 2 != 0) {
                z = safeBP36Mult(z, x);
            }
        }
    }
    // return minimum of two values
    function min(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x <= y) ? x : y;
    }
    // return maximum of two values
    function max(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x >= y) ? x : y;
    }
    // helper
    function assert(bool assertion) internal {
        if (!assertion) {
          throw;
        }
    }

}
