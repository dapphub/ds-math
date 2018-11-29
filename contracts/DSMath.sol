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

import "./DSMathL.sol";

contract DSMath {
    using DSMathL for uint;
    using DSMathL for int;

    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    function add(uint x, uint y) public pure returns (uint z) {
        return x.ds_add(y);
    }
    
    function sub(uint x, uint y) public pure returns (uint z) {
        return x.ds_sub(y);
    }

    function mul(uint x, uint y) public pure returns (uint z) {
        return x.ds_mul(y);
    }

    function min(uint x, uint y) public pure returns (uint z) {
        return x.ds_min(y);
    }

    function max(uint x, uint y) public pure returns (uint z) {
        return x.ds_max(y);
    }

    function imin(int x, int y) public pure returns (int z) {
        return x.ds_imin(y);
    }

    function imax(int x, int y) public pure returns (int z) {
        return x.ds_imax(y);
    }

    function wmul(uint x, uint y) public pure returns (uint) {
        return x.ds_wmul(y);
    }

    function rmul(uint x, uint y) public pure returns (uint) {
        return x.ds_rmul(y);
    }

    function wdiv(uint x, uint y) public pure returns (uint) {
        return x.ds_wdiv(y);
    }

    function rdiv(uint x, uint y) public pure returns (uint) {
        return x.ds_rdiv(y);
    }

    function rpow(uint x, uint n) public pure returns (uint) {
        return x.ds_rpow(n);
    }
}
