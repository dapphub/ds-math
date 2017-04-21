/// math.sol -- mixin for inline numerical wizardry

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.10;

contract DSMath {
    
    /*
    standard uint256 functions
     */

    function add(uint256 x, uint256 y) constant internal returns (uint256 z) {
        assert((z = x + y) >= x);
    }

    function sub(uint256 x, uint256 y) constant internal returns (uint256 z) {
        assert((z = x - y) <= x);
    }

    function mul(uint256 x, uint256 y) constant internal returns (uint256 z) {
        assert((z = x * y) >= x);
    }

    function div(uint256 x, uint256 y) constant internal returns (uint256 z) {
        z = x / y;
    }

    function pow(uint256 x, uint256 n) constant internal returns (uint256 z) {
        
        z = (x == 0 && n > 0) ? 0 : 1;

        for (uint i = 0; i < n; i++) {
            assert((z = mul(z, x)) >= x);
        }
    } 

    function min(uint256 x, uint256 y) constant internal returns (uint256 z) {
        return (x <= y) ? x : y;
    }
    function max(uint256 x, uint256 y) constant internal returns (uint256 z) {
        return (x >= y) ? x : y;
    }

    /*
    uint128 functions (h is for half)
     */


    function hadd(uint128 x, uint128 y) constant internal returns (uint128 z) {
        assert((z = x + y) >= x);
    }

    function hsub(uint128 x, uint128 y) constant internal returns (uint128 z) {
        assert((z = x - y) <= x);
    }

    function hmul(uint128 x, uint128 y) constant internal returns (uint128 z) {
        assert((z = x * y) >= x);
    }

    function hdiv(uint128 x, uint128 y) constant internal returns (uint128 z) {
        z = x / y;
    }

    function hpow(uint128 x, uint128 n) constant internal returns (uint128 z) {
        
        z = (x == 0 && n > 0) ? 0 : 1;

        for (uint i = 0; i < n; i++) {
            assert((z = hmul(z, x)) >= x);
        }
    }

    function hmin(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x <= y) ? x : y;
    }
    function hmax(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x >= y) ? x : y;
    }


    /*
    int256 functions
     */


    function iadd(int256 x, int256 y) constant internal returns (int256 z) {
        z = x + y;
    }

    function isub(int256 x, int256 y) constant internal returns (int256 z) {
        z = x - y;
    }

    function imul(int256 x, int256 y) constant internal returns (int256 z) {
        z = x * y;
    }

    function idiv(int256 x, int256 y) constant internal returns (int256 z) {
        z = x / y;
    }

    function ipow(int256 x, int256 n) constant internal returns (int256 z) {
        assert(!(x == 0 && n < 0));

        // 0^n = 0
        // 1^n = 1
        z = ((x == 0 && n > 0) || (x != 1 && n < 0)) ? 0 : 1;

        for (int i = 0; i < n; i++) {
            z = imul(z, x);
        }
    }

    function imin(int256 x, int256 y) constant internal returns (int256 z) {
        return (x <= y) ? x : y;
    }
    function imax(int256 x, int256 y) constant internal returns (int256 z) {
        return (x >= y) ? x : y;
    }

}
