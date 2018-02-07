<h2>DSMath
  <small class="text-muted">
    <a href="https://github.com/dapphub/ds-math"><span class="fa fa-github"></span></a>
  </small>
</h2>

_Safe Arithmetic_

DS-Math provides arithmetic functions for the common numerical primitive types
 of Solidity. You can safely add, subtract, multiply, and divide `uint` numbers 
without fear of integer overflow. You can also find the minimum and maximum of 
two numbers.

Additionally, this package provides arithmetic functions for new two higher 
level numerical concepts called wad (18 decimals) and ray (27 decimals). These 
are used to represent fixed-point decimal numbers. 

A wad is a decimal number with 18 digits of precision and a ray is a decimal 
number with 27 digits of precision. These functions are necessary to account for 
the difference between how integer arithmetic behaves normally, and how decimal 
arithmetic should actually work. A brief example using `wmul`, which returns the 
product of a wad and another number:

```solidity
1.1 * 2.2 == 2.42

//Regular integer arithmetic adds orders of magnitude:

110 * 220 == 24200

// Wad arithmetic does not add orders of magnitude:

wmul(1.1 ether, 2.2 ether) == 2.42 ether
```

### Naming Convention

The standard functions are the `uint` set, so their function names are not 
prefixed: `add`, `sub`, `mul`, `min`, and `max`. There is no `div` function, as 
divide-by-zero checking is built into the Solidity compiler.

The `int` functions have an `i` prefix: `imin`, and `imax`.

Wad functions have a `w` prefix: `wmul`, `wdiv`.

Ray functions have a `r` prefix: `rmul`, `rdiv`, `rpow`.

### API Reference

#### `add`
Return `x + y` or an exception in case of `uint` overflow.

#### `sub`
Return `x - y` or an exception in case of `uint` overflow.

#### `mul`
Return `x * y` or an exception in case of `uint` overflow.

#### `min`
Return the smaller number of `x` and  `y`.

#### `max`
Return the larger number of `x` and  `y`.

#### `imin`
Return the smaller number of `x` and  `y`.

#### `imax`
Return the larger number of `x` and  `y`.

#### `wmul`
Multiply two Wads and return a new Wad with the correct level of precision. A 
Wad is a decimal number with 18 digits of precision that is being represented 
as an integer.

#### `wdiv`
Divide two Wads and return a new Wad with the correct level of precision. A 
Wad is a decimal number with 18 digits of precision that is being represented 
as an integer.

#### `rmul`
Multiply two Rays and return a new Ray with the correct level of precision. A 
Ray is a decimal number with 27 digits of precision that is being represented 
as an integer.

#### `rdiv`
Divide two Rays and return a new Ray with the correct level of precision. A 
Ray is a decimal number with 27 digits of precision that is being represented 
as an integer.

#### `rpow`
Raise a Ray to the n^th power and return a new Ray with the correct level of 
precision. A Ray is a decimal number with 27 digits of precision that is being 
represented as an integer.
