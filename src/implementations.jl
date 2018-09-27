# MaxPlus Semiring Implementation
# MaxPlus is over real numbers with max as addition and + as multiplication
# The zero element is -inf and the one element is 0

struct MaxPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
+(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(max(l.val, r.val))
*(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(l.val+r.val)
zero(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement{T}(typemin(T))
one(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement{T}(zero(T))

# MinPlus Semiring Implementation
# MinPlus is over real numbers with min as addition and + as multiplication
# The zero element is +inf and the one element is 0

struct MinPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
+(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(min(l.val, r.val))
*(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(l.val+r.val)
zero(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement{T}(typemax(T))
one(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement{T}(zero(T))

# Real (or Probabilistic) Semiring Implementation
# The Real Semiring is over real numbers with + as addition and * as multiplication
# The zero element is 0 and the one element is 1

struct RealSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
+(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(l.val+r.val)
*(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(l.val*r.val)
zero(::Type{RealSemiringElement{T}}) where T = RealSemiringElement(zero(T))
one(::Type{RealSemiringElement{T}}) where T = RealSemiringElement(one(T))

# Boolean Semiring Implementation
# The Boolean Semiring is over {True, False} with OR as addition and AND as multiplication
# The zero element is False and the one element is True

struct BooleanSemiringElement{Bool} <: AbstractSemiringElement{Bool}
    val::Bool
end

# interface methods
+(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement(l.val & r.val)
*(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement(l.val | r.val)
zero(::Type{BooleanSemiringElement{T}}) where T = BooleanSemiringElement{T}(zero(T))
one(::Type{BooleanSemiringElement{T}}) where T = BooleanSemiringElement{T}(one(T))