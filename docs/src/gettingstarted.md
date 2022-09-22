
# Getting Started

## Usage

## Using Units

Units from `Unitful.jl` are a drop-in substitution for numbers

```@example simple
using Orbits
using Plots
using Unitful

orbit = SimpleOrbit(period=10u"d", duration=5u"hr")
t = range(-6, 6, length=1000)u"hr"

pos = mapreduce(ti -> relative_position(orbit, ti), hcat, t)
x, y, z = eachrow(pos);

scatter(x, y, xlabel="x", ylabel="y")
```

```@example simple
scatter(y, z, xlabel="y", ylabel="z")
```

```@example simple
scatter(x, z, xlabel="x", ylabel="z")
```