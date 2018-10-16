_NI(x) = error("not implemented: $x")
_ND(x) = error("$x not defined for this semiring")
abstract type AbstractSemiringElement{T} <: Number end

# mandatory methods
+(::AbstractSemiringElement, ::AbstractSemiringElement) = _NI("addition")
*(::AbstractSemiringElement, ::AbstractSemiringElement) = _NI("multiplication")
one(::Type{AbstractSemiringElement}) = _NI("one() for $R")
zero(::Type{AbstractSemiringElement}) = _NI("zero() for $R")

# optional methods (if the semiring has more structure)
-(::AbstractSemiringElement) = _ND("subtraction")
/(::AbstractSemiringElement, ::AbstractSemiringElement) = _ND("division")
star(::AbstractSemiringElement) = _ND("star") # to do: nice postfix unary operator for this
