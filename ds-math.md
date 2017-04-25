Arithmetic in Solidity
======================

When it comes to arithmetic, the Solidity language and compiler
currently leave a few things to be desired.

First, due to the possibility of over- and underflow, all the basic
arithmetic operations, like addition (`+`), multiplication (`*`),
subtraction (`-`) and division (`/`), are inherently dangerous.
This issue is often repeated in security audits of Solidity code.

Second, there is no built-in way to perform non-integer arithmetic.
(A simple example of this is multiplying a token amount by a price.)
This needs to be handled using so-called "fixed-point arithmetic."

At DappHub, we have arrived at our own standard set of solutions to
these problems, which we use in all our Solidity code, as well as make
available as an open-source library called `ds-math`.

This document explains these solutions and the reasoning behind them.


Safe arithmetic
---------------

Integer overflow and underflow as a result of arithmetic operations is
one of the major security problems seen in Solidity code in the wild.
This is important, so it's worthwhile to explain this in some detail.

At the EVM layer, there is no such thing as "raising an exception" as
a result of an arithmetic operation.  Instead, all arithmetic opcodes
are defined to produce certain valid outputs for all possible inputs.

The first opcode is `ADD` (`0x01`).  Like all of them, it takes two
256-bit numbers ("words") as input and produces one word as output.
The question is, what happens when the sum of the inputs is too large
to fit in a word?  Answer: it wraps around.  This is called overflow.

Example: The largest 256-bit number is `2^256 - 1` (`0xffff...ffff`).
If you `ADD` anything other than zero to this number, the result will
actually be less than either of the two numbers you started with.

The next opcodes are `MUL` (`0x02`) and `SUB` (`0x03`).  They behave
similarly to `ADD` (except `SUB` produces "underflow," not overflow).
These three opcodes correspond almost exactly to the `+`, `*` and `-`
operators in Solidity, which also produce overflow and underflow.

This is the core of the problem.  When writing Solidity code it's very
easy to forget about this surprising and totally undesired behavior,
and any number of disastrous security issues can arise from this.

The Solidity compiler team are working on fixing this by changing
these operators to compile into bytecode which will raise an exception
in these cases, instead of silently producing an incorrect result.

This is a breaking change planned for a future Solidity version (see
<https://github.com/ethereum/solidity/issues/796> for more details),
but for now, the `+`, `*` and `-` operators remain highly problematic.

In the meantime, we recommend using these `ds-math` functions instead:

    function add(uint256 x, uint256 y) internal returns (uint256 z) {
        assert((z = x + y) >= x);
    }

    function mul(uint256 x, uint256 y) internal returns (uint256 z) {
        assert((z = x * y) >= x);
    }

    function sub(uint256 x, uint256 y) internal returns (uint256 z) {
        assert((z = x - y) <= x);
    }

For example:

    // BAD -- potential security hole
    expiration = block.timestamp + lifetime * multiplier;

    // GOOD -- safe arithmetic
    expiration = add(block.timestamp, mul(lifetime, multiplier));

    // BAD -- potential security hole
    balanceOf[msg.sender] -= amount;
    balanceOf[recipient] += amount;

    // GOOD -- safe arithmetic
    balanceOf[msg.sender] = sub(balanceOf[msg.sender], amount);
    balanceOf[recipient] = add(balanceOf[recipient], amount);

When it comes to division, recent versions of Solidity do in fact
throw an error in case of division by zero.  However, an even more
subtle kind of overflow bug can occur in case of signed division.
(See <https://github.com/ethereum/solidity/issues/1087> for details.)

Therefore, we recommend this function instead of the `/` operator:

    function div(uint256 x, uint256 y) internal returns (uint256 z) {
        z = x / y;
    }

This ensures that you are not accidentally using signed division.

**Conclusion:** Always use the `add`, `mul`, `sub` and `div` functions
instead of the built-in `+`, `*`, `-` and `/` operators.

In addition, though less common, note that the `**` and `%` operators
also suffer from similar problems.  Safe versions of these will be
added in a future version of `ds-math` (called `exp` and `mod`).

[TODO: Add information about the `hadd` and `iadd` series.]


Fixed-point arithmetic
----------------------

[TODO: Add information about this.]
