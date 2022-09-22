using ChainRulesCore
using ChainRulesTestUtils
using QuadGK
using StableRNGs
using Orbits
using Test
using Unitful
using UnitfulAstro

Unitful.preferunits(u"Rsun,Msun,d"...)
ENV["UNITFUL_FANCY_EXPONENTS"] = false

# Numpy version of `isapprox`
# https://stackoverflow.com/questions/27098844/allclose-how-to-check-if-two-arrays-are-close-in-julia/27100515#27100515
allclose(a, b; rtol=1e-5, atol=1e-8) = mapreduce((a,b) -> abs(a - b) ≤ (atol + rtol*abs(b)), &, a, b)

rng = StableRNG(2752)

@testset "Orbits" begin
    include("keplerian.jl")
    include("simple.jl")
    include("solvers.jl")
    include("show.jl")
end
