@testset "≈ test" begin
    x = RealSemiringElement(3)
    y = RealSemiringElement(3.00000000001)
    z = MaxPlusSemiringElement(3)
    @test x != y
    @test x ≈ y
    @test x ≈ x
    @test_throws DomainError x ≈ z
end