using Transits
using Transits.Orbits: rotate_vector, compute_true_anomaly
using BenchmarkTools

orbit = KeplerianOrbit((
	aRₛ = 7.5,
	P = 2.0,
	# incl = π / 2.0,
	b = 0.0,
	t₀ = 0.0,
	ecc = 0.0,
	Ω = 0.0,
	ω = 0.0,
))

rotate_vector(orbit, 0.5, 1)
@benchmark rotate_vector($orbit, 0.5, 1)

using StaticArrays
using Rotations
function rotate_vector2(orbit, x, y)
    X = SA[x, y, 0]
    R = RotZXZ(orbit.ω, -orbit.incl, orbit.Ω)
    return R * X
end

rotate_vector2(orbit, 0.5, 1)
@benchmark rotate_vector($orbit, 0.5, 1)

using Test
@testset "" begin
    for x in range(-1, 1, length=100), y in range(-1, 1, length=100)
        @test rotate_vector(orbit, x, y) == rotate_vector2(orbit, x, y)
    end
end