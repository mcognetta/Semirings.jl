@testset "val" begin
    x = RealSemiringElement(3.0)
    @test val(x) ≈ 3
    @test typeof(val(x)) == eltype(x)
end