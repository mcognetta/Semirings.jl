# Semirings.jl
#### A Julia library for [semirings.](https://en.wikipedia.org/wiki/Semiring)


[![Build Status](https://travis-ci.com/mcognetta/Semirings.jl.svg?branch=master)](https://travis-ci.com/mcognetta/Semirings.jl)
[![codecov](https://codecov.io/gh/mcognetta/Semirings.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mcognetta/Semirings.jl)
[![Coverage Status](https://coveralls.io/repos/github/mcognetta/Semirings.jl/badge.svg?branch=master)](https://coveralls.io/github/mcognetta/Semirings.jl?branch=master)

This provides implementations for several important semirings as well as a small interface so that you can define your own.

Provided semirings:
- Real Semiring: `RealSemiringElement` - `(R, +, *, 0, 1)`
- Max Plus: `MaxPlusSemiringElement` - `(R, max, +, -, -∞, 0)`
- Min Plus: `MinPlusSemiringElement` - `(R, min, +, -,  ∞, 0)`
- Boolean: `BooleanSemiringElement` - `({False, True}, OR, AND, False, True)`

Suppose we wish to define the `MySemiring` semiring. First make the type:
```
MySemiringElement{T} <: AbstractSemiringElement{T}
```
Then define the following methods for your semiring:
1. `val(x::MySemiringElement)` - Get the value of the element
2. `+(l::MySemiringElement, r::MySemiringElement)` - Addition for your semiring
3. `*(l::MySemiringElement, r::MySemiringElement)` - Multiplication for your semiring
4. `zero(::Type{MySemiringElement})` - The `0` element in your semiring
5. `one(::Type{MySemiringElement})` - The `1` element in your semiring

Implementing these gives access to all of the other operations that are present in all semirings as well as several helpful methods concering promotion, conversion, semiring type inspection, etc.

Assuming the `eltype` of your semiring has the appropriate conversion and promotion rules, everything else should just work. This includes using your `MySemiringElement` in vectors and matrices (although some additional methods must be defined in order to have access to all of the `LinearAlgebra` functionality).

If your semiring has additional structure (a division, complete, star, etc. semiring), you can define a few more operations to access a variety of new functionality.

When applicable, one can implement:
1. `-(x::MySemiringElement)` - additive inversion
2. `/(x::MySemiringElement, y::MySemiringElement)` - semiring division
3. `star(x::MySemiringElement)` - semiring star operation

and the associated semiring functionality will then be defined automatically.

## To do
1. Adding `SimpleTraits` to denote semiring properties (idempotent, nilpotent, complete, division, etc)
2. Better operator for `star`
3. Include `conj` in the docs or work around it for `RealSemiringElements`
