### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ be430d60-7416-11eb-3564-dbc9e4728bb8
using Distributions, Random

# ╔═╡ d74af610-744d-11eb-0cf1-19a8fdac8dfb
begin
	using Plots
	pyplot()
end

# ╔═╡ e28ea850-7439-11eb-2db3-09f8e94faa19
# Problem 8

# ╔═╡ 9a0d12f2-7417-11eb-19f0-ad2b95fb7417
function f(p)
	res = 0
	c = 0
	for _ in 1:10000
		a = []
		for _ in 1:20
			push!(a,rand(Bernoulli(1-p)))
			if ((count(a.== 0)*-1+count(a.==1)+10)==0)
				break
			end
		end
		if length(a)==20
			c+=1
			if sum(a)>=10
				res+=1
			end
		end
	end
return res/c
end

# ╔═╡ 6c663200-744e-11eb-23cd-dd4e3ad697d2
f(0.34)

# ╔═╡ d8894270-744d-11eb-3c71-8704e514ddb3
plot(f,0,1)

# ╔═╡ Cell order:
# ╠═e28ea850-7439-11eb-2db3-09f8e94faa19
# ╠═be430d60-7416-11eb-3564-dbc9e4728bb8
# ╠═9a0d12f2-7417-11eb-19f0-ad2b95fb7417
# ╠═6c663200-744e-11eb-23cd-dd4e3ad697d2
# ╠═d74af610-744d-11eb-0cf1-19a8fdac8dfb
# ╠═d8894270-744d-11eb-3c71-8704e514ddb3
