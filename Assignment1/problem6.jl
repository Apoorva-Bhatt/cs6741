### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 31f06a2e-7405-11eb-0fcc-cfc19af20b2e
using Distributions, Random

# ╔═╡ 0f73e922-7412-11eb-3ab9-bb9f023dab4e
begin
	using Plots
	pyplot()
end

# ╔═╡ d4f02d40-7439-11eb-195f-45a9e09fc39b


# ╔═╡ 6a8b4532-7406-11eb-3d46-4116fcfe12c3
function f(p)
	res = 0
	n = 6
	for _ in 1:10^n
		b = Bernoulli(1-p)
		c = rand(b, 20)
		if sum(c)>=10
			res+=1
		end
	end
	res/10^n
end

# ╔═╡ 4d75c910-7407-11eb-2621-7f06099067c4
p = collect(LinRange(0,1,11))

# ╔═╡ d4e17d80-7408-11eb-0203-3f4caa504849
result = [f(p[i]) for i=1:11]

# ╔═╡ 4535f710-7412-11eb-3bbd-47e7d6bb0335
plot(f,0,1)

# ╔═╡ Cell order:
# ╠═d4f02d40-7439-11eb-195f-45a9e09fc39b
# ╠═31f06a2e-7405-11eb-0fcc-cfc19af20b2e
# ╠═6a8b4532-7406-11eb-3d46-4116fcfe12c3
# ╠═4d75c910-7407-11eb-2621-7f06099067c4
# ╠═d4e17d80-7408-11eb-0203-3f4caa504849
# ╠═0f73e922-7412-11eb-3ab9-bb9f023dab4e
# ╠═4535f710-7412-11eb-3bbd-47e7d6bb0335
