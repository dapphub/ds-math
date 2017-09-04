/// math.sol -- mixin for inline numerical wizardry

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.13;

contract DSMath {
    function add(uint x, uint y) constant internal returns (uint z) {
        assert((z = x + y) >= x);
    }
    function sub(uint x, uint y) constant internal returns (uint z) {
        assert((z = x - y) <= x);
    }

    function mul(uint x, uint y) constant internal returns (uint z) {
        z = x * y;
        assert(x == 0 || z / x == y);
    }
    function div(uint x, uint y) constant internal returns (uint z) {
        z = x / y;
    }

    function min(uint x, uint y) constant internal returns (uint z) {
        return x <= y ? x : y;
    }
    function max(uint x, uint y) constant internal returns (uint z) {
        return x >= y ? x : y;
    }

    function imin(int x, int y) constant internal returns (int z) {
        return x <= y ? x : y;
    }
    function imax(int x, int y) constant internal returns (int z) {
        return x >= y ? x : y;
    }

    uint constant WAD = 10 ** 18;

    function wmul(uint x, uint y) constant internal returns (uint z) {
        z = (x * y + WAD / 2) / WAD;
        assert(x == 0 || wdiv(z, x) == y);
    }
    function wdiv(uint x, uint y) constant internal returns (uint z) {
        z = (x * WAD + y / 2) / y;
    }

    uint constant RAY = 10 ** 27;

    function rmul(uint x, uint y) constant internal returns (uint z) {
        z = (x * y + RAY / 2) / RAY;
        assert(x == 0 || rdiv(z, x) == y);
    }
    function rdiv(uint x, uint y) constant internal returns (uint z) {
        z = (x * RAY + y / 2) / y;
    }

    function rpow(uint x, uint n) constant internal returns (uint z) {
        // This famous algorithm is called "exponentiation by squaring"
        // and calculates x^n with x as fixed-point and n as regular unsigned.
        //
        // It's O(log n), instead of O(n) for naive repeated multiplication.
        //
        // These facts are why it works:
        //
        //  If n is even, then x^n = (x^2)^(n/2).
        //  If n is odd,  then x^n = x * x^(n-1),
        //   and applying the equation for even x gives
        //    x^n = x * (x^2)^((n-1) / 2).
        //
        //  Also, EVM division is flooring and
        //    floor[(n-1) / 2] = floor[n / 2].

        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }
}
