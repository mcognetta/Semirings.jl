using SimpleTraits

@testset "basic functionality test" begin
    x = BooleanSemiringElement(true)
    y = BooleanSemiringElement(false)
    z = BooleanSemiringElement{Bool}(true)

    @test x == z
    @test x != y != z
    @test x+y isa BooleanSemiringElement
    @test x*y isa BooleanSemiringElement
    @test x+y == y+x == x
    @test x+z == z+x == z == x

    @test zero(BooleanSemiringElement) == y
    @test one(BooleanSemiringElement) == x
    
    @test iszero(zero(BooleanSemiringElement))
    @test isone(one(BooleanSemiringElement))

    @test x⊕y == x+y
    @test x⊙y == x*y
end

@testset "conversions between elements of the same semiring with different types" begin
    x = RealSemiringElement{Int64}(3)
    y = RealSemiringElement{Float64}(11.1)
    z = RealSemiringElement{Int16}(1)

    xc = convert(RealSemiringElement{Float64}, x)
    yc = convert(RealSemiringElement{Float64}, y)
    zc = convert(RealSemiringElement{Float64}, z)
    
    @test x == xc
    @test y == yc
    @test z == zc
    
    @test x+x isa RealSemiringElement{Int64}
    @test y+y isa RealSemiringElement{Float64}
    @test z+z isa RealSemiringElement{Int16}
    @test x+y isa RealSemiringElement{Float64}
    @test x+z isa RealSemiringElement{Int64}
    @test y+z isa RealSemiringElement{Float64}

    @test xc isa RealSemiringElement{Float64}
    @test yc isa RealSemiringElement{Float64}
    @test zc isa RealSemiringElement{Float64}
end

@testset "operations between different semirings" begin
    x = MaxPlusSemiringElement(3.0)
    y = MinPlusSemiringElement(5.0)
    z = RealSemiringElement(2)
    
    # TODO: make these domain errors
    @test_throws ErrorException x+y
    @test_throws ErrorException x+z
    @test_throws ErrorException y+z
end

@testset "semiring type methods" begin
    x = RealSemiringElement(3)
    y = RealSemiringElement(5.0)
    z = MaxPlusSemiringElement(11.2)

    @test issamesemiring(x, y)
    @test !issamesemiring(x, z)
    @test !issamesemiring(y, z)

    @test semiring(x) <: RealSemiringElement
    @test eltype(semiring(x)) == Int64
    @test eltype(semiring(z)) == Float64
end

@testset "vectors and matrices" begin
    A = MaxPlusSemiringElement{Int64}[3 5; 1 2]
    B = MaxPlusSemiringElement{Int64}[10 6; -1 -2]

    @test A+B == MaxPlusSemiringElement{Int64}[10 6; 1 2]
    @test A*B == MaxPlusSemiringElement{Int64}[13 9; 11 7]

    C = MaxPlusSemiringElement{Float64}[1.0 2.0; 3.0 4.0]
    D = MaxPlusSemiringElement[1.0 2.0; 3.0 4.0]
    E = MaxPlusSemiringElement{Float64}[1 2; 3 4]
    @test C == D == E

    x = rand(3,3)
    y = rand(3)
    F = convert(Matrix{RealSemiringElement{Float64}}, x)
    G = convert(Matrix{RealSemiringElement{Float64}}, x+x)
    H = convert(Matrix{RealSemiringElement{Float64}}, x*x)
    I = convert(Vector{RealSemiringElement{Float64}}, y)
    J = convert(Vector{RealSemiringElement{Float64}}, x*y)

    @test F isa Matrix{RealSemiringElement{Float64}}
    @test G isa Matrix{RealSemiringElement{Float64}}
    @test H isa Matrix{RealSemiringElement{Float64}}
    @test I isa Vector{RealSemiringElement{Float64}}
    @test J isa Vector{RealSemiringElement{Float64}}

    @test F+F == G
    @test F*F == H
    @test F*I == J

    @test A+C isa Matrix{MaxPlusSemiringElement{Float64}}
end

@testset "promotion" begin
    x = MinPlusSemiringElement(3)
    y = MinPlusSemiringElement(4.0)
    z = MinPlusSemiringElement(5//3)
    a = MaxPlusSemiringElement(1)

    @test promote_type(typeof(x), typeof(y), typeof(z)) == MinPlusSemiringElement{Float64}
    xp, yp, zp = promote(x, y, z)
    @test xp isa promote_type(typeof(x), typeof(y), typeof(z))
    @test yp isa promote_type(typeof(x), typeof(y), typeof(z))
    @test zp isa promote_type(typeof(x), typeof(y), typeof(z))
    @test_throws DomainError promote(x, y, z, a)
end

@testset "test each implementation" begin
    for S in (RealSemiringElement, MaxPlusSemiringElement, MinPlusSemiringElement)
        for elty in (Int32, Int64, Float32, Float64, Rational)
            x = S(elty(5))
            y = S(elty(6))
            z = S(elty(2))
            @test x+zero(x) == zero(x) + x == x
            @test x*one(x) == one(x)*x == x
            @test zero(x)*(x+y) == (x+y)*zero(x) == zero(x)
            @test (x+y)*z == x*z + y*z
            @test z*(x+y) == z*x + z*y
        end
    end

    x = BooleanSemiringElement(true)
    y = BooleanSemiringElement(false)
    z = BooleanSemiringElement(true)

    @test x+zero(x) == zero(x) + x == x
    @test x*one(x) == one(x)*x == x
    @test zero(x)*(x+y) == (x+y)*zero(x) == zero(x)
    @test (x+y)*z == x*z + y*z
    @test z*(x+y) == z*x + z*y

    # optional methods defined for RealSemiringElements

    x = RealSemiringElement(3.0)
    y = RealSemiringElement(0.5)

    @test x-x == zero(x)
    @test x/x == one(x)
    @test x/y == RealSemiringElement(3.0/0.5)
    @test x*inv(x) == one(x)
    @test_throws DomainError star(x)
    @test star(y) == RealSemiringElement(1/(1-.5))

    @test y+addinv(y) == addinv(y)+y == zero(y)
    @test y*mulinv(y) == mulinv(y)*y == one(y)
end

@testset "traits" begin
    @traitfn commutativetest(x::X) where {X; IsCommutative{X}} = true
    @traitfn commutativetest(x::X) where {X; !IsCommutative{X}} = false

    @traitfn idempotenttest(x::X) where {X; IsIdempotent{X}} = true
    @traitfn idempotenttest(x::X) where {X; !IsIdempotent{X}} = false

    @traitfn startest(x::X) where {X; IsStar{X}} = true
    @traitfn startest(x::X) where {X; !IsStar{X}} = false

    w = BooleanSemiringElement(true)
    x = MaxPlusSemiringElement(3.0)
    y = MinPlusSemiringElement(5.0)
    z = RealSemiringElement(2)

    @test commutativetest(w)
    @test commutativetest(x)
    @test commutativetest(y)
    @test commutativetest(z)

    @test idempotenttest(w)
    @test idempotenttest(x)
    @test idempotenttest(y)
    @test !idempotenttest(z)

    @test startest(w)
    @test startest(x)
    @test startest(y)
    @test startest(z)
end