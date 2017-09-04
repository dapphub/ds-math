
#######
DS-Math
#######

.. |readthedocs| image:: https://img.shields.io/badge/view%20docs-readthedocs-blue.svg?style=flat-square
   :target: https://dappsys.readthedocs.io/en/latest/ds_math.html   

.. |chat| image:: https://img.shields.io/badge/community-chat-blue.svg?style=flat-square
   :target: https://dapphub.chat
   
|readthedocs|  |chat|


DS-Math provides arithmetic functions for the common numerical primitive types of Solidity. You can safely add, subtract, multiply, and divide ``uint`` numbers without fear of integer overflow. You can also find the minimum and maximum of two numbers.

Additionally, this package provides arithmetic functions for new two higher level numerical concepts called wad (18 decimals) and ray (27 decimals). These are used to represent fixed-point decimal numbers. 

A wad is a decimal number with 18 digits of precision and a ray is a decimal number with 27 digits of precision. These functions are necessary to account for the difference between how integer arithmetic behaves normally, and how decimal arithmetic should actually work. A brief example using ``wmul``, which returns the product of a wad and another number:

::

    1.1 * 2.2 = 2.24

    Regular integer arithmetic adds orders of magnitude:

    110 * 220 = 22400

    Wad arithmetic does not add orders of magnitude:

    wmul(1100000000000000000, 2200000000000000000) = 2240000000000000000


**Naming Convention:** 

The standard functions are the ``uint`` set, so their function names are not prefixed: ``add``, ``sub``, ``mul``, ``div``, ``min``, and ``max``.

The ``int`` functions have an ``i`` prefix: ``imin``, and ``imax``.

Wad functions have a ``w`` prefix: ``wmul``, ``wdiv``.

Ray functions have a ``r`` prefix: ``rmul``, ``rdiv``, ``rpow``.

DSMath
======

Your contract should inherit from this type if you want to perform safe arithmetic functions on ``uint`` or ``int`` primitive types, or decimal numbers being represented with unsigned integers.

Import
------
``import ds-math/math.sol``

Parent Types
------------

None


API Reference
-------------

function add
^^^^^^^^^^^^

This function will return ``x + y`` unless it results in a ``uint`` overflow, in which case it will throw an exception.

::

    function add(uint x, uint y) constant internal returns (uint z)

function sub
^^^^^^^^^^^^

This function will return ``x - y`` unless it results in a ``uint`` overflow, in which case it will throw an exception.

::

    function sub(uint x, uint y) constant internal returns (uint z)

function mul
^^^^^^^^^^^^

This function will return ``x * y`` unless it results in a ``uint`` overflow, in which case it will throw an exception.

::

    function mul(uint x, uint y) constant internal returns (uint z)

function div
^^^^^^^^^^^^

This function will return ``x / y`` unless ``y`` is equal to 0, in which case it will throw an exception.

::

    function div(uint x, uint y) constant internal returns (uint z)

function min
^^^^^^^^^^^^

This function returns the smaller number between ``x`` and ``y``.

::

    function min(uint x, uint y) constant internal returns (uint z)


function max
^^^^^^^^^^^^

This function returns the larger number between ``x`` and ``y``.

::

    function max(uint x, uint y) constant internal returns (uint z)


function imin
^^^^^^^^^^^^^

This function returns the smaller number between ``x`` and ``y``.

::

    function imin(int256 x, int256 y) constant internal returns (int256 z)


function imax
^^^^^^^^^^^^^

This function returns the larger number between ``x`` and ``y``.

::

    function imax(int256 x, int256 y) constant internal returns (int256 z)


function wmul
^^^^^^^^^^^^^

This function will multiply two Wads and return a new Wad with the correct level of precision. A Wad is a decimal number with 18 digits of precision that is being represented as an integer. To learn more, see the introduction to DS-Math above.

::

    function wmul(uint x, uint y) constant internal returns (uint z)

function wdiv
^^^^^^^^^^^^^

This function will divide two Wads and return a new Wad with the correct level of precision. A Wad is a decimal number with 18 digits of precision that is being represented as an integer. To learn more, see the introduction to DS-Math above.

::
    
    function wdiv(uint x, uint y) constant internal returns (uint z)

function rmul
^^^^^^^^^^^^^

This function will multiply two Rays and return a new Ray with the correct level of precision. A Ray is a decimal number with 27 digits of precision that is being represented as an integer. To learn more, see the introduction to DS-Math above.

::
    
    function rmul(uint x, uint y) constant internal returns (uint z)

function rdiv
^^^^^^^^^^^^^

This function will divide two Rays and return a new Ray with the correct level of precision. A Ray is a decimal number with 27 digits of precision that is being represented as an integer. To learn more, see the introduction to DS-Math above.

::

    function rdiv(uint x, uint y) constant internal returns (uint z)


function rpow
^^^^^^^^^^^^^

This function will raise a Ray to the n^th power and return a new Ray with the correct level of precision. A Ray is a decimal number with 27 digits of precision that is being represented as an integer. To learn more, see the introduction to DS-Math above.

::
    
    function rpow(uint x, uint n) constant internal returns (uint z)
