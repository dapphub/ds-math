/// math.sol -- mixin for inline numerical wizardry

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

pragma solidity 0.4.24;

library DSMathL {
    function ds_add(uint x, uint y) public pure returns (uint z) {
        require((z = x + y) >= x, "ds-math-add-overflow");
    }
    function ds_sub(uint x, uint y) public pure returns (uint z) {
        require((z = x - y) <= x, "ds-math-sub-underflow");
    }
    function ds_mul(uint x, uint y) public pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, "ds-math-mul-overflow");
    }

    function ds_min(uint x, uint y) public pure returns (uint z) {
        return x <= y ? x : y;
    }
    function ds_max(uint x, uint y) public pure returns (uint z) {
        return x >= y ? x : y;
    }
    function ds_imin(int x, int y) public pure returns (int z) {
        return x <= y ? x : y;
    }
    function ds_imax(int x, int y) public pure returns (int z) {
        return x >= y ? x : y;
    }

    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    function ds_wmul(uint x, uint y) public pure returns (uint z) {
        z = ds_add(ds_mul(x, y), WAD / 2) / WAD;
    }
    function ds_rmul(uint x, uint y) public pure returns (uint z) {
        z = ds_add(ds_mul(x, y), RAY / 2) / RAY;
    }
    function ds_wdiv(uint x, uint y) public pure returns (uint z) {
        z = ds_add(ds_mul(x, WAD), y / 2) / y;
    }
    function ds_rdiv(uint x, uint y) public pure returns (uint z) {
        z = ds_add(ds_mul(x, RAY), y / 2) / y;
    }

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
    //
    function ds_rpow(uint x, uint n) public pure returns (uint z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = ds_rmul(x, x);

            if (n % 2 != 0) {
                z = ds_rmul(z, x);
            }
        }
    }
}
