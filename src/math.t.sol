pragma solidity ^0.4.8;

import "./math.sol";

contract Test is OverflowProtectable {
    function testFail_safeAdd() {
        safeAdd(2 ** 128 - 1, 1);
    }
    function test_safeAdd() {
        assertEq(uint(safeAdd(2 ** 128 - 1, 0)), 2 ** 128 - 1);
        assertEq(uint(safeAdd(1.2 ether, 3.4 ether)), 4.6 ether);
    }

    function testFail_safeSub() {
        safeSub(3.4 ether, 3.4 ether + 1 wei);
    }
    function test_safeSub() {
        assertEq(uint(safeSub(3.4 ether, 1.2 ether)), 2.2 ether);
    }

    function testFail_safeBP18Mult_overflow() {
        safeBP18Mult(2 ** 128 - 1, 1.0 ether + 1 wei);
    }
    function test_safeBP18Mult_trivial() {
        assertEq(uint(safeBP18Mult(2 ** 128 - 1, 1.0 ether)), 2 ** 128 - 1);
        assertEq(uint(safeBP18Mult(0.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(safeBP18Mult(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(safeBP18Mult(1.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(safeBP18Mult(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_safeBP18Mult_fractions() {
        assertEq(uint(safeBP18Mult(1.0 ether, 0.2 ether)), 0.2 ether);
        assertEq(uint(safeBP18Mult(2.0 ether, 0.2 ether)), 0.4 ether);
    }

    function testFail_safeBP18Div_zero() {
        safeBP18Div(1.0 ether, 0.0 ether);
    }
    function test_safeBP18Div_trivial() {
        assertEq(uint(safeBP18Div(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(safeBP18Div(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_safeBP18Div_fractions() {
        assertEq(uint(safeBP18Div(1.0 ether, 2.0 ether)), 0.5 ether);
        assertEq(uint(safeBP18Div(2.0 ether, 2.0 ether)), 1.0 ether);
    }
}
