module Semirings

# SimpleTraits is only used for a secondary hierarchy of semirings (commutative, idempotent, etc)

using SimpleTraits

# imports from base

import Base: show, convert, eltype, promote_rule
import Base: +, *, ==, -, /, inv, conj
import Base: zero, one, iszero, isone

# exporting types, new functions, and new symbols

export AbstractSemiringElement
export ⊕, ⊙, star, mulinv, addinv, val
export issamesemiring, semiring

# traits
export IsCommutative, iscommutative, IsIdempotent, isidempotent, IsStar, isstar

# export implementations

export MaxPlusSemiringElement, MinPlusSemiringElement, RealSemiringElement, BooleanSemiringElement

# includes

include("interface.jl")
include("traits.jl")
include("core.jl")
include("implementations.jl")

end # module
