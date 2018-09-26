Base.eltype(::Type{R}) where {T, R<:AbstractSemiringElement{T}} = T

==(l::R, r::R) where {R<:AbstractSemiringElement} = l.val == r.val

Base.zero(::Type{R}) where {T, R<:AbstractSemiringElement{T}} = R(zero(T))
Base.one(::Type{R}) where {T, R<:AbstractSemiringElement{T}} = R(one(T))
Base.iszero(x::R) where {R<:AbstractSemiringElement} = x == zero(R)
Base.isone(x::R) where {R<:AbstractSemiringElement} = x == one(R)

⊕(l::AbstractSemiringElement, r::AbstractSemiringElement) = +(l,r) 
⊙(l::AbstractSemiringElement, r::AbstractSemiringElement) = *(l,r) 

(::Type{R})(v) where {R<:AbstractSemiringElement} = R(v)