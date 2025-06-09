using Measurements
using Orbits
using Documenter
using Documenter.Remotes: GitHub

setup = quote
    using Orbits
end

DocMeta.setdocmeta!(Orbits, :DocTestSetup, setup; recursive=true)

include("pages.jl")

makedocs(;
    modules = [Orbits],
    authors = "Miles Lucas <mdlucas@hawaii.edu> and contributors",
    repo = GitHub("https://github.com/juliaAstro/Orbits.jl"),
    sitename = "Orbits.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://juliaastro.org/Orbits/stable/",
    ),
    pages=pages,
)

deploydocs(;
    repo = "github.com/JuliaAstro/Orbits.jl.git",
    push_preview = true,
    versions = ["stable" => "v^", "v#.#"], # Restrict to minor releases
)
