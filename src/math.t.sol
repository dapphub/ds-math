// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity >0.4.13;

import "ds-test/test.sol";
import "./math.sol";

contract DSMathTest is DSTest, DSMath {
    function testFail_add() public pure {
        add(2 ** 256 - 1, 1);
    }
    function test_add() public {
        assertEq(add(0, 0), 0);
        assertEq(add(0, 1), 1);
        assertEq(add(1, 1), 2);
    }

    function testFail_sub() public pure {
        sub(0, 1);
    }
    function test_sub() public {
        assertEq(sub(0, 0), 0);
        assertEq(sub(1, 1), 0);
        assertEq(sub(2, 1), 1);
    }

    function testFail_mul() public pure {
        mul(2 ** 254, 6);
    }

    function test_mul() public {
        assertEq(mul(0, 1), 0);
        assertEq(mul(1, 1), 1);
        assertEq(mul(2, 1), 2);
    }

    function test_min() public {
        assertEq(min(1, 1), 1);
        assertEq(min(1, 2), 1);
    }
    function test_max() public {
        assertEq(max(1, 1), 1);
        assertEq(max(1, 2), 2);
    }
    function test_imin() public {
        assertEq(imin(1, 1), 1);
        assertEq(imin(1, 2), 1);
        assertEq(imin(1, -2), -2);
    }
    function test_imax() public {
        assertEq(imax(1, 1), 1);
        assertEq(imax(1, 2), 2);
        assertEq(imax(1, -2), 1);
    }

    function testFail_wmul_overflow() public pure {
        wmul(2 ** 128, 2 ** 128);
    }
    function test_wmul_trivial() public {
        assertEq(wmul(2 ** 128 - 1, 1.0 ether), 2 ** 128 - 1);
        assertEq(wmul(0.0 ether, 0.0 ether), 0.0 ether);
        assertEq(wmul(0.0 ether, 1.0 ether), 0.0 ether);
        assertEq(wmul(1.0 ether, 0.0 ether), 0.0 ether);
        assertEq(wmul(1.0 ether, 1.0 ether), 1.0 ether);
    }
    function test_wmul_fractions() public {
        assertEq(wmul(1.0 ether, 0.2 ether), 0.2 ether);
        assertEq(wmul(2.0 ether, 0.2 ether), 0.4 ether);
    }

    function testFail_wdiv_zero() public pure {
        wdiv(1.0 ether, 0.0 ether);
    }
    function test_wdiv_trivial() public {
        assertEq(wdiv(0.0 ether, 1.0 ether), 0.0 ether);
        assertEq(wdiv(1.0 ether, 1.0 ether), 1.0 ether);
    }
    function test_wdiv_fractions() public {
        assertEq(wdiv(1.0 ether, 2.0 ether), 0.5 ether);
        assertEq(wdiv(2.0 ether, 2.0 ether), 1.0 ether);
    }

    function test_wmul_rounding() public {
        uint a = .950000000000005647 ether;
        uint b = .000000001 ether;
        uint c = .00000000095 ether;
        assertEq(wmul(a, b), c);
        assertEq(wmul(b, a), c);
    }
    function test_rmul_rounding() public {
        uint a = 1 ether;
        uint b = .95 ether * 10**9 + 5647;
        uint c = .95 ether;
        assertEq(rmul(a, b), c);
        assertEq(rmul(b, a), c);
    }
}
