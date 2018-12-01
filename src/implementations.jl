# MaxPlus Semiring Implementation
# MaxPlus is over real numbers with max as addition and + as multiplication
# The zero element is -inf and the one element is 0

struct MaxPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
val(x::MaxPlusSemiringElement) = x.val
+(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(max(l.val, r.val))
*(l::MaxPlusSemiringElement, r::MaxPlusSemiringElement) = MaxPlusSemiringElement(l.val+r.val)
zero(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement(-Inf)
one(::Type{MaxPlusSemiringElement{T}}) where T = MaxPlusSemiringElement{T}(0)

iscommutative(::Type{<:MaxPlusSemiringElement}) = true
isidempotent(::Type{<:MaxPlusSemiringElement}) = true
isstar(::Type{<:MaxPlusSemiringElement}) = true

# MinPlus Semiring Implementation
# MinPlus is over real numbers with min as addition and + as multiplication
# The zero element is +inf and the one element is 0

struct MinPlusSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
val(x::MinPlusSemiringElement) = x.val
+(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(min(l.val, r.val))
*(l::MinPlusSemiringElement, r::MinPlusSemiringElement) = MinPlusSemiringElement(l.val+r.val)
zero(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement(Inf)
one(::Type{MinPlusSemiringElement{T}}) where T = MinPlusSemiringElement{T}(0)

iscommutative(::Type{<:MinPlusSemiringElement}) = true
isidempotent(::Type{<:MinPlusSemiringElement}) = true
isstar(::Type{<:MinPlusSemiringElement}) = true


# Real (or Probabilistic) Semiring Implementation
# The Real Semiring is over real numbers with + as addition and * as multiplication
# The zero element is 0 and the one element is 1

struct RealSemiringElement{T<:Real} <: AbstractSemiringElement{T}
    val::T
end

# interface methods
val(x::RealSemiringElement) = x.val
+(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(l.val+r.val)
*(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(l.val*r.val)
zero(::Type{RealSemiringElement{T}}) where T = RealSemiringElement(0)
one(::Type{RealSemiringElement{T}}) where T = RealSemiringElement(1)

iscommutative(::Type{<:RealSemiringElement}) = true
isstar(::Type{<:RealSemiringElement}) = true

# optional methods
-(x::RealSemiringElement) = RealSemiringElement(-x.val)
/(l::RealSemiringElement, r::RealSemiringElement) = RealSemiringElement(l.val/r.val)
function star(x::RealSemiringElement)
    0 <= x.val < 1 ? RealSemiringElement(1/(1-x.val)) : throw(DomainError("$x must be within [0, 1)"))
end

for op in (:conj,) # required for matrix inversion?
    @eval begin
        $op(x::RealSemiringElement) = RealSemiringElement($op(x.val))
    end
end

# Boolean Semiring Implementation
# The Boolean Semiring is over {True, False} with OR as addition and AND as multiplication
# The zero element is False and the one element is True

struct BooleanSemiringElement{Bool} <: AbstractSemiringElement{Bool}
    val::Bool
end

# interface methods
val(x::BooleanSemiringElement) = x.val
+(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement(l.val | r.val)
*(l::BooleanSemiringElement, r::BooleanSemiringElement) = BooleanSemiringElement(l.val & r.val)
zero(::Type{BooleanSemiringElement{T}}) where T = BooleanSemiringElement{T}(false)
one(::Type{BooleanSemiringElement{T}}) where T = BooleanSemiringElement{T}(true)

iscommutative(::Type{<:BooleanSemiringElement}) = true
isidempotent(::Type{<:BooleanSemiringElement}) = true
isstar(::Type{<:BooleanSemiringElement}) = true

#optional methods
star(x::R) where R<:BooleanSemiringElement = one(R)
