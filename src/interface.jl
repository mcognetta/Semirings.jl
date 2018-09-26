_NI(x) = error("not implemented: $x")

abstract type AbstractSemiringElement{T} end

+(::Type{R}, ::Type{R}) where R <: AbstractSemiringElement = _NI("addition")
*(::Type{R}, ::Type{R}) where R <: AbstractSemiringElement = _NI("multiplication")
one(::Type{R}) where R <: AbstractSemiringElement = _NI("one() for $R")
zero(::Type{R}) where R <: AbstractSemiringElement = _NI("zero() for $R")

#promote_rule(::Type{AbstractSemiring}, ::Type{AbstractSemiring}) = error("Cannot convert between semiring types")