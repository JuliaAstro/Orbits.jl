
# Getting Started

## Usage

## Using Units

Units from `Unitful.jl` are a drop-in substitution for numbers

```julia
using Unitful
orbit = SimpleOrbit(period=10u"d", duration=5u"hr")
t = range(-6, 6, length=1000)u"hr"
flux = @. ld(orbit, t, 0.1)
```
