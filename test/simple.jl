using Orbits: relative_position

@testset "simple orbit" begin
    period = 3.456
    t0 = 1.45
    b = 0.5
    duration = 0.12
    t = t0 .+ range(-2.0 * period, 2.0 * period; length=5000)
    m0 = @. abs(mod(t - t0 + 0.5 * period, period) - 0.5 * period) < 0.5 * duration

    orbit = SimpleOrbit(; period, t0, b, duration)
    pos = @. relative_position(orbit, t)
    bs = map(v -> sqrt(v[1]^2.0 + v[2]^2.0), pos)
    zs = map(v -> v[3], pos)
    m = @. (bs ≤ 1.0) & (zs > 0.0)
    @test orbit.ref_time == -0.278
    @test m ≈ m0

    #idxs = in_transit(orbit, t)
    #@test all(bs[idxs] .≤ 1.0)
    #@test all(zs[idxs] .> 0.0)

    # TODO: Do we want this?
    #pos  = @. star_position(orbit, t)
    #for vec in pos
    #    @test all(vec .≈ 0.0)
    #end
end
