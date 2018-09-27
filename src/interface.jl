_NI(x) = error("not implemented: $x")

abstract type AbstractSemiringElement{T} end

+(::Type{AbstractSemiringElement}, ::Type{AbstractSemiringElement}) = _NI("addition")
*(::Type{AbstractSemiringElement}, ::Type{AbstractSemiringElement}) = _NI("multiplication")
one(::Type{AbstractSemiringElement}) = _NI("one() for $R")
zero(::Type{AbstractSemiringElement}) = _NI("zero() for $R")