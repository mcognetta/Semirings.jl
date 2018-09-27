module Semirings

# SimpleTraits is only used for a secondary hierarchy of semirings (commutative, idempotent, etc)

# using SimpleTraits

# imports from base

import Base: show, convert, zero, one, eltype, iszero, isone, promote_rule, promote
import Base: +, *, ==

# exporting types, new functions, and new symbols

export AbstractSemiringElement
export iszero, isone
export ⊕, ⊙
export issamesemiring

# export implementations

export MaxPlusSemiringElement, MinPlusSemiringElement, RealSemiringElement, BooleanSemiringElement

# includes

include("interface.jl")
include("core.jl")
include("implementations.jl")

end # module