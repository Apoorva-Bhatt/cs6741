### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 232d47a0-7439-11eb-0134-9bb072e53914
begin
	using Plots
	pyplot()
end

# ╔═╡ b8adae02-7439-11eb-1c1f-4106a542a663


# ╔═╡ 4190f930-7439-11eb-1f29-af533519a55b
begin
	b=0
	means = []
	for i in 1:100000
		a = rand(-1000:1000)
		push!(means, (b+a)/i)
		b +=a
	end
end

# ╔═╡ 49c7f090-7439-11eb-1d1d-0916f79c1c12
plot(means)

# ╔═╡ Cell order:
# ╠═b8adae02-7439-11eb-1c1f-4106a542a663
# ╠═232d47a0-7439-11eb-0134-9bb072e53914
# ╠═4190f930-7439-11eb-1f29-af533519a55b
# ╠═49c7f090-7439-11eb-1d1d-0916f79c1c12
