eltype(::Type{R}) where {T, R<:AbstractSemiringElement{T}} = T

==(l::R, r::S) where {R<:AbstractSemiringElement, S<:AbstractSemiringElement} = samesemiring(R, S) ? l.val == r.val : error("incompatable semirings")

iszero(x::R) where {R<:AbstractSemiringElement} = x == zero(R)
isone(x::R) where {R<:AbstractSemiringElement} = x == one(R)
convert(::Type{R}, x) where R<:AbstractSemiringElement = R(x)
convert(::Type{R}, x::S) where {R<:AbstractSemiringElement, S<:AbstractSemiringElement} = samesemiring(R, S) ? R(x.val) : error("incompatable semirings")

function promote_rule(::Type{R}, ::Type{S}) where {T, U, R<:AbstractSemiringElement{T}, S<:AbstractSemiringElement{U}}
    Z = typejoin(R, S)
    isabstracttype(Z) ? error("incompatable semiring types") : Z{promote_type(T, U)}
end

⊕(l::AbstractSemiringElement, r::AbstractSemiringElement) = +(l,r) 
⊙(l::AbstractSemiringElement, r::AbstractSemiringElement) = *(l,r) 

(::Type{R})(v::T) where {T, R<:AbstractSemiringElement} = R{T}(v)

samesemiring(l::R, r::S) where {R<:AbstractSemiringElement, S<: AbstractSemiringElement} = !isabstracttype(typejoin(R, S))
samesemiring(::Type{R}, ::Type{S}) where {R<:AbstractSemiringElement, S<: AbstractSemiringElement} = !isabstracttype(typejoin(R, S))