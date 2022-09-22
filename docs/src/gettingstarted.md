
# Getting Started

## Usage

Let's create the simplest realization of an orbit we can- the [`SimpleOrbit`](@ref)

```@example simple
using Orbits
using Plots
using Unitful
using UnitfulAstro
using UnitfulRecipes

orbit = SimpleOrbit(period=10u"d", duration=5u"hr")
```

let's look at a more advanced orbit. Here we present the orbital solution for the binary system SAO 136799, as derived by Tokovinin et al. 2015[^1]

```@example kep
using Measurements
using Orbits
using Plots
using Unitful
using UnitfulAstro
using UnitfulRecipes

distance = inv(6.92e-3)u"pc"

orbit = KeplerianOrbit(;
    period = (40.57 ± 0.19)u"yr",
    ecc = 0.42 ± 0.009,
    Omega = (318.6 ± 0.6)u"°",
    tp = (1972.12 ± 0.16)u"yr",
    incl = (54.7 ± 0.6)u"°",
    a = (0.154 ± 0.001) * 144.51u"AU",
    omega = (72.6 ± 0.8)u"°",
)
plot(orbit; label="")
scatter!([0], [0], c=:black, marker=:+, lab="SAO 136799A")
```

we can show the orbit in sky angles by providing the distance to the system

```@example kep
plot(orbit; label="", distance)
scatter!([0], [0], c=:black, marker=:+, lab="SAO 136799A")
```

## Calculating ephemerides

Using out above orbit, let's figure out the position of the secondary star on a specific date

```@example kep
using Dates

function year_as_decimal(date::DateTime)
    year_start = DateTime(Dates.year(date), 1, 1)
    year_end = DateTime(Dates.year(date) + 1, 1, 1)
    fraction = (date - year_start) / (year_end - year_start)
    return (Dates.year(year_start) + fraction)u"yr"
end

obs_time = DateTime(2022, 2, 19, 10, 29, 45)
time = year_as_decimal(obs_time)
```

```@example kep
pos = relative_position(orbit, time)
# convert to angles for plot
ra, dec, _ = @. pos / distance |> u"arcsecond"
scatter!([ra], [dec], lab="SAO 136799B")
```

## Getting binary parameters

Continuing our above example, let's calculate the position angle and separation of the binary at the observing date above

```@example kep
using Orbits: position_angle, separation

pa = position_angle(orbit, time)
sep = separation(orbit, time) / distance |> u"arcsecond"
pa, sep
```

let's show that with a polar plot; keep in mind the polar plot has 0 degrees as the positive x-axis, but parallactic angles start at the axis with the north celestial pole, which is 90 degrees in the polar plot.

```@example kep
scatter([deg2rad(pa - 270)], [sep], proj=:polar, lab="SAO 136799B")
```

### SkyCoords.jl

These ephemerides can be translated into SkyCoords easily-

```@example kep
using AstroAngles
using SkyCoords

origin = ICRSCoords(dms"09 22 50.8563427", hms"-09 50 19.659199")
```

```@example kep
using Measurements: value

coord = offset(origin, value(sep), deg2rad(value(pa)))
```


[^1]: Tokovinin et al. (2015) "Speckle Interferometry at SOAR in 2014" ([ads](https://ui.adsabs.harvard.edu/abs/2015AJ....150...50T))