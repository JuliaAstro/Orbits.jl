using RecipesBase

@recipe function f(orbit::KeplerianOrbit; N=90, distance=nothing)
    # We almost always want to see spatial coordinates with equal step sizes
    aspect_ratio --> 1
    # And we almost always want to reverse the RA coordinate to match how we
    # see it in the sky.
    xflip --> true
    if isnothing(distance)
        xguide --> "Δx"
        yguide --> "Δy"
    end

    # We trace out in equal steps of true anomaly instead of time for a smooth
    # curve, regardless of eccentricity.
    νs = range(-π, π; length=N)
    pos = @. _position(orbit, -orbit.aR_star, sin(νs), cos(νs))

    xs = map(p -> p[1], pos)
    ys = map(p -> p[2], pos)

    if !isnothing(distance)
        xs = @. uconvert(u"arcsecond", xs / distance)
        ys = @. uconvert(u"arcsecond", ys / distance)
        xguide --> "Δra"
        yguide --> "Δdec"
    end

    return xs, ys
end
