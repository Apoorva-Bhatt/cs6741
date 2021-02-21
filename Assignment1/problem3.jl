### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6f8edff0-73a3-11eb-1af5-399c8817f7e8
using Distributions

# ╔═╡ 5bb67600-73a3-11eb-3172-d71b75e72b4a
# Problem 3

# ╔═╡ cc3040f0-73a3-11eb-1d4f-bb6d9da537ae
@bind n_jacks html"<input type=range min=0 max=4>"

# ╔═╡ aef68912-73a6-11eb-3b2a-7dce0e1afe02
# With Replacement 

# ╔═╡ 7f445420-73a3-11eb-2a92-8fcaeff724ef
D_b = Binomial(5, 1/13)

# ╔═╡ 746a1740-73a5-11eb-2d0d-1d8d3570bba6
my_func(x) = pdf(D_b, x)

# ╔═╡ 987059b0-73a5-11eb-0593-5be1288c166a
my_func(n_jacks)

# ╔═╡ bb8d7f30-73a6-11eb-31ea-c3a8cd5cb79a
# Without Replacement

# ╔═╡ c3d602c0-73a6-11eb-13fb-c7948f65865a
D_h = Hypergeometric(4, 48, 5)

# ╔═╡ 02501ef0-73a7-11eb-147c-556e892e550f
my_fun(x) = pdf(D_h, x)

# ╔═╡ f8854120-73a6-11eb-219d-3bcc89237571
my_fun(n_jacks)

# ╔═╡ Cell order:
# ╠═5bb67600-73a3-11eb-3172-d71b75e72b4a
# ╠═6f8edff0-73a3-11eb-1af5-399c8817f7e8
# ╠═cc3040f0-73a3-11eb-1d4f-bb6d9da537ae
# ╠═aef68912-73a6-11eb-3b2a-7dce0e1afe02
# ╠═7f445420-73a3-11eb-2a92-8fcaeff724ef
# ╠═746a1740-73a5-11eb-2d0d-1d8d3570bba6
# ╠═987059b0-73a5-11eb-0593-5be1288c166a
# ╠═bb8d7f30-73a6-11eb-31ea-c3a8cd5cb79a
# ╠═c3d602c0-73a6-11eb-13fb-c7948f65865a
# ╠═02501ef0-73a7-11eb-147c-556e892e550f
# ╠═f8854120-73a6-11eb-219d-3bcc89237571
