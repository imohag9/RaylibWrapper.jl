using RaylibWrapper
using Test
using Aqua
using Pkg.Artifacts

@testset "RaylibWrapper.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(RaylibWrapper)
    end


    @testset "Artifact: raylib download verification" begin

        @test !isnothing(libraylib)

    end

    @testset "Artifact: simple usage" begin
        v = Vector2(1, 1)
        v_negate = Vector2Negate(v)
        @test v_negate.x === -1 * v.x
        @test v_negate.y === -1 * v.y
    end
end
