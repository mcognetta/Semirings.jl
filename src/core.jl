eltype(::Type{R}) where {T, R<:AbstractSemiringElement{T}} = T

==(l::R, r::S) where {R<:AbstractSemiringElement, S<:AbstractSemiringElement} = issamesemiring(R, S) ? val(l) == val(r) : error("incompatable semirings")

iszero(x::R) where {R<:AbstractSemiringElement} = x == zero(R)
isone(x::R) where {R<:AbstractSemiringElement} = x == one(R)
convert(::Type{R}, x) where R<:AbstractSemiringElement = R(x)
convert(::Type{R}, x::Number) where R<:AbstractSemiringElement = R(x) # resolving ambiguity
convert(::Type{R}, x::S) where {R<:AbstractSemiringElement, S<:AbstractSemiringElement} = issamesemiring(R, S) ? R(val(x)) : error("incompatable semirings")

zero(::R) where R<:AbstractSemiringElement = zero(R)
one(::R) where R<:AbstractSemiringElement = one(R)

promote_rule(::Type{R}, ::Type{R}) where R<:AbstractSemiringElement = R
function promote_rule(::Type{R}, ::Type{S}) where {T, U, R<:AbstractSemiringElement{T}, S<:AbstractSemiringElement{U}}
    Z = typejoin(R, S)
    isabstracttype(Z) ? error("incompatable semiring types") : Z{promote_type(T, U)}
end

promote(::Type{R}, x::R) where R<:AbstractSemiringElement = x
function promote(::Type{R}, x::S) where {R<:AbstractSemiringElement, S<:AbstractSemiringElement}
    if !issamesemiring(R, S)
        error("incompatable semirings")
    else
        Z = promote_rule(R, S)
        Z == S ? error("$S cannot be promoted to $R") : Z(val(x))
    end
end

# \oplus and \otimes alias for + and *

⊕(l::AbstractSemiringElement, r::AbstractSemiringElement) = +(l, r) 
⊙(l::AbstractSemiringElement, r::AbstractSemiringElement) = *(l, r)

(::Type{R})(v::T) where {T, R<:AbstractSemiringElement} = R(convert(T, v))

# some operations on the semiring type

semiring(::S) where S<: AbstractSemiringElement = S
issamesemiring(::Type{R}, ::Type{S}) where {R<:AbstractSemiringElement, S<: AbstractSemiringElement} = !isabstracttype(typejoin(R, S))

# implementations stemming from the optional interface

-(l::AbstractSemiringElement, r::AbstractSemiringElement) = l+(-r)
inv(x::R) where R<:AbstractSemiringElement = one(R)/x
mulinv(x::AbstractSemiringElement) = inv(x)
addinv(x::R) where R<:AbstractSemiringElement = -x
