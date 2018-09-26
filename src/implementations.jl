# MaxPlus Semiring Implementation
# MaxPlus is over real numbers with max as addition and + as multiplication
# The zero element is -inf and the one element is 0

struct MaxPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

MaxPlusSemiringElement(val::T) where T = MaxPlusSemiringElement{T}(val)

# interface methods
+(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(max(promote(l.val, r.val)...))
*(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(+(promote(l.val, r.val)...))
promote_rule(::Type{R}, ::Type{S}) where {R<:MaxPlusSemiringElement, S<:MaxPlusSemiringElement} = MaxPlusSemiringElement{promote_type(eltype(R), eltype(S))}
convert(::Type{R}, x::T) where {T<:Real, R<:MaxPlusSemiringElement} = MaxPlusSemiringElement{T}(x)
convert(::Type{MaxPlusSemiringElement{T}}, x::MaxPlusSemiringElement) where T = MaxPlusSemiringElement{promote_type(T, eltype(x))}(x.val)

# overwrites of some methods
zero(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement{T}(typemin(T))
one(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement{T}(zero(T))

# MinPlus Semiring Implementation
# MinPlus is over real numbers with min as addition and + as multiplication
# The zero element is +inf and the one element is 0

struct MinPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

MinPlusSemiringElement(val::T) where T = MinPlusSemiringElement{T}(val)

# interface methods
+(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(min(promote(l.val, r.val)...))
*(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(+(promote(l.val, r.val)...))
promote_rule(::Type{R}, ::Type{S}) where {R<:MinPlusSemiringElement, S<:MinPlusSemiringElement} = MinPlusSemiringElement{promote_type(eltype(R), eltype(S))}
convert(::Type{R}, x::T) where {T<:Real, R<:MinPlusSemiringElement} = MinPlusSemiringElement{T}(x)
convert(::Type{MinPlusSemiringElement{T}}, x::MinPlusSemiringElement) where T = MinPlusSemiringElement{promote_type(T, eltype(x))}(x.val)

# overwrites of some methods
zero(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement{T}(typemax(T))
one(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement{T}(zero(T))

# Real (or Probabilistic) Semiring Implementation
# The Real Semiring is over real numbers with + as addition and * as multiplication
# The zero element is 0 and the one element is 1

struct RealSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

RealSemiringElement(val::T) where T = RealSemiringElement{T}(val)

# interface methods
+(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(+(promote(l.val, r.val)...))
*(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(*(promote(l.val, r.val)...))
promote_rule(::Type{R}, ::Type{S}) where {R<:RealSemiringElement, S<:RealSemiringElement} = RealSemiringElement{promote_type(eltype(R), eltype(S))}
convert(::Type{R}, x::T) where {T<:Real, R<:RealSemiringElement} = RealSemiringElement{T}(x)
convert(::Type{RealSemiringElement{T}}, x::RealSemiringElement) where T = RealSemiringElement{promote_type(T, eltype(x))}(x.val)

# Boolean Semiring Implementation
# The Boolean Semiring is over {True, False} with OR as addition and AND as multiplication
# The zero element is False and the one element is True

struct BooleanSemiringElement{Bool} <: AbstractSemiringElement{Bool}
    val::Bool
end

BooleanSemiringElement(val::T) where T = BooleanSemiringElement{T}(val)

# interface methods
+(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement((&)(promote(l.val, r.val)...))
*(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement((|)(promote(l.val, r.val)...))
promote_rule(::Type{R}, ::Type{S}) where {R<:BooleanSemiringElement, S<:BooleanSemiringElement} = BooleanSemiringElement{promote_type(eltype(R), eltype(S))}
convert(::Type{R}, x::T) where {T<:Real, R<:BooleanSemiringElement} = BooleanSemiringElement{T}(x)
convert(::Type{BooleanSemiringElement{T}}, x::BooleanSemiringElement) where T = BooleanSemiringElement{promote_type(T, eltype(x))}(x.val)