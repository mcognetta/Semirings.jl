# Commutative semirings have commutative multiplication (addition is commutative by definition).
@traitdef IsCommutative{S<:AbstractSemiringElement}
@traitimpl IsCommutative{S} <- iscommutative(S)
is_commutative(x) = false

# Idempotent semirings are semirings with idempotent addition: `a+a = a`
@traitdef IsIdempotent{S<:AbstractSemiringElement}
@traitimpl IsIdempotent{S} <- isidempotent(S)
isidempotent(::Type{<:AbstractSemiringElement}) = false


# Star semirings have an additional unary operator `*`: `a^* = \sum_{i = 0}^{\infty} a^i`.
@traitdef IsStar{S<:AbstractSemiringElement}
@traitimpl IsStar{S} <- isstar(S)
isstar(::Type{<:AbstractSemiringElement}) = false
