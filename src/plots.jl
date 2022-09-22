using RecipesBase

@recipe function f(orbit::AbstractOrbit; N = 90, distance = nothing)
    # We almost always want to see spatial coordinates with equal step sizes
    aspect_ratio --> 1
    # And we almost always want to reverse the RA coordinate to match how we
    # see it in the sky.
    xflip --> true
    xguide --> "Δx"
    yguide --> "Δy"

    # We trace out in equal steps of true anomaly instead of time for a smooth
    # curve, regardless of eccentricity.
    νs = range(-π, π; length = N)
    pos = @. _position(orbit, -orbit.aR_star, sin(νs), cos(νs))

    xs = map(p -> p[1] * oneunit(orbit.R_star), pos)
    ys = map(p -> p[2] * oneunit(orbit.R_star), pos)

    if !isnothing(distance)
        d_pc = ustrip(u"pc", distance)
        xs = @. ustrip(u"AU", xs) / d_pc * u"arcsecond"
        ys = @. ustrip(u"AU", ys) / d_pc * u"arcsecond"
    end

    return xs, ys
end
