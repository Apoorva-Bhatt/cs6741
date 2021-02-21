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

# ╔═╡ f817347e-738f-11eb-248e-3f57095c2cbb
using StatsBase, Random

# ╔═╡ afcf5df0-72d7-11eb-10a4-75c6c92e55ef
# Problem 2

# ╔═╡ ecb54540-743a-11eb-19cb-33df250a5184
#take into consideration that number of jacks drawn can not be more than 4.

# ╔═╡ e7161860-738d-11eb-250d-93913865db6a
@bind n_jacks html"<input type=range min=0 max=4>"

# ╔═╡ bef509a0-73a5-11eb-29a9-3d1f656e879e
# with replacement

# ╔═╡ d0dbc340-7385-11eb-302d-cbc75f08c9a1
begin
	cards = []
	res = 0
	n = 10^6
	Random.seed!(0)
	for _ in 1:n
		cards = sample(1:52, 5, replace = true)
		num = count(x->x<5, cards)
		if num == n_jacks
			res+=1
		end
	end
	res/n
end

# ╔═╡ c8266692-73a5-11eb-25b2-df11a76b2b88
#without replacement

# ╔═╡ b3b0f720-7396-11eb-3eb0-a783134cbf7c
begin
	card = []
	result = 0
	Random.seed!(0)
	for _ in 1:n
		card = sample(1:52, 5, replace = false)
		num = count(x->x<5, card)
		if num == n_jacks
			result +=1
		end
	end
	result/n
end

# ╔═╡ 0f9f6a80-7455-11eb-2264-c77bb3c34609
(1/13)^3*(48/52)^2

# ╔═╡ 218e7b00-7455-11eb-1243-256657746743


# ╔═╡ Cell order:
# ╠═afcf5df0-72d7-11eb-10a4-75c6c92e55ef
# ╠═f817347e-738f-11eb-248e-3f57095c2cbb
# ╠═ecb54540-743a-11eb-19cb-33df250a5184
# ╠═e7161860-738d-11eb-250d-93913865db6a
# ╠═bef509a0-73a5-11eb-29a9-3d1f656e879e
# ╠═d0dbc340-7385-11eb-302d-cbc75f08c9a1
# ╠═c8266692-73a5-11eb-25b2-df11a76b2b88
# ╠═b3b0f720-7396-11eb-3eb0-a783134cbf7c
# ╠═0f9f6a80-7455-11eb-2264-c77bb3c34609
# ╠═218e7b00-7455-11eb-1243-256657746743
