### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 4a8863c0-7420-11eb-36c9-0362026d10a8
using Distributions, Random

# ╔═╡ cdb10360-7439-11eb-0789-7b6c240632f9
# Problem 5

# ╔═╡ 512ed010-7420-11eb-2a75-6fe444e5b085
D_b = Binomial(8, 1/78)

# ╔═╡ 62a5ca60-7420-11eb-217a-c947e233d029
f(x) = pdf(D_b, x)

# ╔═╡ 1abd04b0-7421-11eb-2247-6baa11c4029f
function fun()
	r = 1
	i = 0
	while (r*1000000>1000)
		r-=f(i)
		i+=1
	end
	return i
end

# ╔═╡ 8176a030-7421-11eb-2440-9bf1fa6506cd
fun()

# ╔═╡ Cell order:
# ╠═cdb10360-7439-11eb-0789-7b6c240632f9
# ╠═4a8863c0-7420-11eb-36c9-0362026d10a8
# ╠═512ed010-7420-11eb-2a75-6fe444e5b085
# ╠═62a5ca60-7420-11eb-217a-c947e233d029
# ╠═1abd04b0-7421-11eb-2247-6baa11c4029f
# ╠═8176a030-7421-11eb-2440-9bf1fa6506cd
