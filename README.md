# Semirings.jl
#### A Julia library for [semirings.](https://en.wikipedia.org/wiki/Semiring)


[![Build Status](https://travis-ci.com/mcognetta/Semirings.jl.svg?branch=master)](https://travis-ci.com/mcognetta/Semirings.jl)
[![codecov](https://codecov.io/gh/mcognetta/Semirings.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mcognetta/Semirings.jl)

This provides implementations for several important semirings as well as a small interface so that you can define your own.

Provided semirings:
- Real Semiring: `RealSemiringElement` - `(R, +, *, 0, 1)`
- Max Plus: `MaxPlusSemiringElement` - `(R, max, +, -∞, 0)`
- Min Plus: `MinPlusSemiringElement` - `(R, min, +, ∞, 0)`
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

#### Traits
We use [SimpleTraits](https://github.com/mauro3/SimpleTraits.jl) to add additional dispatch capabilities for semirings. These traits encode structural properties of the semiring (commutative, idempotent, star, etc). We currently have support for:
1. Commutative - `IsCommutative`/`iscommutative` - semirings with commutative multiplication
2. Idempotent - `IsIdempotent`/`isidempotent` - semirings with idempotent addition
3. Star - `IsStar`/`isstar` - semirings with a defined star operator

If your semiring has one of these traits, you can connect them by defining (for example) `isidempotent(::Type{<:MySemiringElement}) = true`. New traits can be defined by following the template in `src/traits.jl`.

## To do
- [x] Adding `SimpleTraits` to denote semiring properties (idempotent, nilpotent, complete, division, etc)
- [ ] Better operator for `star`
- [ ] Include `conj` in the docs or work around it for `RealSemiringElements`
