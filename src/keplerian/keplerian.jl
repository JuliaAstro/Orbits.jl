using AstroLib: trueanom, kepler_solver
using KeywordCalls
using Rotations
using Unitful
using Unitful: AbstractQuantity
using UnitfulAstro

# Domain specific unit conversions / constants/ fallbacks
Unitful.preferunits(u"Msun,Rsun,d"...)
const G_unit = Unitful.G
const G_nom = ustrip(u"Rsun^3/Msun/d^2", G_unit)

# Helpers
include("kepler_helpers.jl")
include("constructor.jl")


# Finds the position `r` of the planet along its orbit after rotating
# through the true anomaly `ν`, then transforms this from the
# orbital plan to the equatorial plane
# separation: aR_star, a/R_star, a_star / R_star, or a_planet / R_star
# TODO: consider moving this to a separate orbital calculations package in the future
function _position(orbit, separation, t)
    sin_ν, cos_ν = compute_true_anomaly(orbit, t)
    return _position(orbit, separation, sin_ν, cos_ν)
end

# get a _position that takes true anomaly directly, useful for plotting
function _position(orbit, separation, true_anom_sin, true_anom_cos)
    if isnothing(orbit.ecc) || iszero(orbit.ecc)
        r = separation
    else
        r = separation * (1 + orbit.ecc) * (1 - orbit.ecc) / (1 + orbit.ecc * true_anom_cos)
    end
    # Transform from orbital plane to equatorial plane
    X = SA[r*true_anom_cos, r*true_anom_sin, zero(r)] * oneunit(orbit.R_star)
    R = RotZXZ(orbit.Omega, -orbit.incl, orbit.omega)
    return R * X
end
_star_position(orb, R_star, t) = _position(orb, orb.a_star / R_star, t)
_planet_position(orb, R_star, t) = _position(orb, orb.a_planet / R_star, t)
relative_position(orbit::KeplerianOrbit, t) = _position(orbit, -orbit.aR_star, t)

# Returns sin(ν), cos(ν)
function compute_true_anomaly(orbit::KeplerianOrbit, t)
    M = compute_M(t, orbit.t0, orbit.t_ref, orbit.n)
    if isnothing(orbit.ecc) || iszero(orbit.ecc)
        return sincos(M)
    else
        E = kepler_solver(uconvert(NoUnits, M), orbit.ecc)
        return sincos(trueanom(E, orbit.ecc))
    end
end

function flip(orbit::KeplerianOrbit, R_planet)
    if isnothing(orbit.ecc) || iszero(orbit.ecc)
        return KeplerianOrbit(
            period = orbit.period,
            tp = orbit.tp + 0.5 * orbit.period,
            incl = orbit.incl,
            Omega = orbit.Omega,
            omega = orbit.omega,
            M_star = orbit.M_planet,
            M_planet = orbit.M_star,
            R_star = R_planet,
            R_planet = orbit.R_star,
            ecc = orbit.ecc,
        )
    else
        return KeplerianOrbit(
            period = orbit.period,
            tp = orbit.tp,
            incl = orbit.incl,
            Omega = orbit.Omega,
            omega = orbit.omega - π,
            M_star = orbit.M_planet,
            M_planet = orbit.M_star,
            R_star = R_planet,
            R_planet = orbit.R_star,
            ecc = orbit.ecc,
        )
    end
end

