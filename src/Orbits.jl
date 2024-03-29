module Orbits

using ConcreteStructs
using StaticArrays
using Printf

export SimpleOrbit, KeplerianOrbit, relative_position

abstract type AbstractOrbit end

Base.broadcastable(o::AbstractOrbit) = Ref(o)

"""
    relative_position(::AbstractOrbit, t)

The relative position, `[x, y, z]`, of the companion compared to the host at time `t`. In
other words, this is the vector pointing from the host to the companion along the line of
sight. Nominally, the units of this distance are relative to the host's radius. For
example, a distance of 2 is 2 *stellar* radii.
"""
relative_position(::AbstractOrbit, t)

"""
    position_angle(::AbstractOrbit, t)

Calculates the position angle (in degrees) of the companion at time `t`
"""
function position_angle(orbit::AbstractOrbit, t)
    x, y, _ = relative_position(orbit, t)
    return atand(-y, -x)
end

"""
    separation(::AbstractOrbit, t)

Calculates the separation of the companion at time `t`
"""
function separation(orbit::AbstractOrbit, t)
    x, y, _ = relative_position(orbit, t)
    return sqrt(x^2 + y^2)
end

"""
    flip(::AbstractOrbit)
    
Return a new orbit with the primary and secondary swapped.
"""
function flip end

include("simple.jl")
include("keplerian/keplerian.jl")
include("plots.jl")

end # module
