// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-test/test.sol";
import "./token_math.sol";

contract DSTokenMathTest is DSTest, DSTokenMath {

    function testFail_wmul_overflow() {
        wmul(2 ** 128 - 1, 1.0 ether + 1 wei);
    }
    function test_wmul_trivial() {
        assertEq(uint(wmul(2 ** 128 - 1, 1.0 ether)), 2 ** 128 - 1);
        assertEq(uint(wmul(0.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(wmul(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(wmul(1.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(wmul(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_wmul_fractions() {
        assertEq(uint(wmul(1.0 ether, 0.2 ether)), 0.2 ether);
        assertEq(uint(wmul(2.0 ether, 0.2 ether)), 0.4 ether);
    }

    function testFail_wdiv_zero() {
        wdiv(1.0 ether, 0.0 ether);
    }
    function test_wdiv_trivial() {
        assertEq(uint(wdiv(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(wdiv(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_wdiv_fractions() {
        assertEq(uint(wdiv(1.0 ether, 2.0 ether)), 0.5 ether);
        assertEq(uint(wdiv(2.0 ether, 2.0 ether)), 1.0 ether);
    }
}
