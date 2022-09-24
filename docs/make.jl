using Orbits
using Documenter

setup = quote
    using Orbits
end

DocMeta.setdocmeta!(Orbits, :DocTestSetup, setup; recursive=true)

include("pages.jl")

makedocs(;
    modules=[Orbits],
    authors="Miles Lucas <mdlucas@hawaii.edu> and contributors",
    repo="https://github.com/juliaastro/Orbits.jl/blob/{commit}{path}#L{line}",
    sitename="Orbits.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://juliaastro.github.io/Orbits.jl",
        assets=String[],
    ),
    pages=pages,
)

deploydocs(; repo="github.com/JuliaAstro/Orbits.jl", push_preview=true, devbranch="main")
