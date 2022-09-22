```@meta
CurrentModule = Orbits
```

# Orbits.jl

[![GitHub](https://img.shields.io/badge/Code-GitHub-black.svg)](https://github.com/juliaastro/Orbits.jl)

[![Build Status](https://github.com/juliaastro/Orbits.jl/workflows/CI/badge.svg?branch=main)](https://github.com/juliaastro/Orbits.jl/actions)
[![PkgEval](https://juliaci.github.io/NanosoldierReports/pkgeval_badges/O/Orbits.svg)](https://juliaci.github.io/NanosoldierReports/pkgeval_badges/report.html)
[![Coverage](https://codecov.io/gh/juliaastro/Orbits.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/juliaastro/Orbits.jl)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaastro.github.io/Orbits.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaastro.github.io/Orbits.jl/dev)

Flexible and fast astronomical orbits (originally a submodule of [Transits.jl](https://github.com/JuliaAstro/Transits.jl)).
The goals of this package are, in this order:
* have a simple interface with high *composability*
* be flexible with respect to numeric types and application
* be fully compatible with [ChainRules.jl](https://github.com/juliadiff/ChainRules.jl) automatic differentiation (AD) system to leverage the derived analytical gradients
* provide a codebase that is well-organized, instructive, and easy to extend
* maintain high performance: at least as fast as similar tools

## Installation

To install use [Pkg](https://julialang.github.io/Pkg.jl/v1/managing-packages/). From the REPL, press `]` to enter Pkg-mode

```julia
pkg> add Orbits
```
If you want to use the most up-to-date version of the code, check it out from `main`

```julia
pkg> add Orbits#main
```

## Contributing and Support

If you would like to contribute, feel free to open a [pull request](https://github.com/JuliaAstro/Orbits.jl/pulls). If you want to discuss something before contributing, head over to [discussions](https://github.com/JuliaAstro/Orbits.jl/discussions) and join or open a new topic.
