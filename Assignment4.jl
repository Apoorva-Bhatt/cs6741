### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 08438790-abd1-11eb-3427-f3a62019dbe4
using Distributions, Random, Plots, StatsBase

# ╔═╡ 198a5ab0-b072-11eb-151d-6d74f4b5208a
gr()

# ╔═╡ 749c7fa0-abd1-11eb-2d16-fdaddd2171ea
#problem 1

# ╔═╡ 0a5470be-abd2-11eb-3e39-e342fa6ca899
begin
	Random.seed!(20)
	count = 0 
	p = 0.5
	for _ in 1:10^6
		v = sum(rand(Binomial(1,p),50))
		if v >= 30
			count+= 1
		end
	end
	mc1 = count/10^6
end

# ╔═╡ 1cd03f3e-b064-11eb-1a12-bb9021fbccbc
begin
	res = 0
	for i in 30:50
		res += binomial(50, i)*(p^i)*(p^(50-i))
	end
	res
end	

# ╔═╡ d2700290-abd2-11eb-3eae-5ff467a68ddc
#problem 2

# ╔═╡ a572fda0-b024-11eb-016c-897a1eab407a
begin
	Random.seed!(0)
	counter = 0 
	p1 = 0.59
	for _ in 1:10^6
		v = sum(rand(Binomial(1,p1),50))
		if v >= 30
			counter+= 1
		end
	end
	mc2 = counter/10^6
end

# ╔═╡ 953ff500-b024-11eb-0246-0366a3b6123f
begin
	res1 = 0
	for i in 30:50
		res1 += binomial(50, i)*(0.59^i)*(0.41^(50-i))
	end
	res1
end	

# ╔═╡ 0ec33900-b066-11eb-1ec8-25664437b4cb
# problem 3

# ╔═╡ ed1405f0-b065-11eb-362a-37c25bd180a3
begin
	Random.seed!(0)
	count2 = 0 
	for _ in 1:10^7
		v = sum(rand(Normal(100,30),33))
		if v >= 3000
			count2+= 1
		end
	end
	mc3 = count2/10^7
end

# ╔═╡ 33d34d80-b06a-11eb-1985-c30bc356ee65
#problem 4

# ╔═╡ 97e7f72e-b0ab-11eb-1719-911e24ef2ac1
D(x) = pdf(Normal(0,1),x)

# ╔═╡ 43342cb0-b0a4-11eb-269c-a176c9c55729
skew_moment(x) = length(x)/((length(x) - 1) * (length(x) - 2)) * sum((x .- mean(x)).^3) / std(x)^3

# ╔═╡ ae257a70-b0d0-11eb-313f-512ca751971c
begin
	function kurtosis_moment(x)
		n = length(x)
		return (n*(n+1)/((n-1)*(n-2)*(n-3)) * sum((x .- mean(x)).^4) / std(x)^4) - 3*(n-1)^2/((n-2)*(n-3))
	end
end

# ╔═╡ 382a99b0-b06a-11eb-1092-03ddece45083
begin
	for z in 1:50
		rv = []
		for i in 1:100
			m = mean(rand(Uniform(0,1),z))
			push!(rv,m)
		end
		arr = (rv.-0.5)*sqrt(12*z)
		if (skew_moment(arr)<0.1 && kurtosis_moment(arr)<0.1)
			z
			break
		end
	end
end

# ╔═╡ Cell order:
# ╠═08438790-abd1-11eb-3427-f3a62019dbe4
# ╠═198a5ab0-b072-11eb-151d-6d74f4b5208a
# ╠═749c7fa0-abd1-11eb-2d16-fdaddd2171ea
# ╠═0a5470be-abd2-11eb-3e39-e342fa6ca899
# ╠═1cd03f3e-b064-11eb-1a12-bb9021fbccbc
# ╠═d2700290-abd2-11eb-3eae-5ff467a68ddc
# ╠═a572fda0-b024-11eb-016c-897a1eab407a
# ╠═953ff500-b024-11eb-0246-0366a3b6123f
# ╠═0ec33900-b066-11eb-1ec8-25664437b4cb
# ╠═ed1405f0-b065-11eb-362a-37c25bd180a3
# ╠═33d34d80-b06a-11eb-1985-c30bc356ee65
# ╠═97e7f72e-b0ab-11eb-1719-911e24ef2ac1
# ╠═43342cb0-b0a4-11eb-269c-a176c9c55729
# ╠═ae257a70-b0d0-11eb-313f-512ca751971c
# ╠═382a99b0-b06a-11eb-1092-03ddece45083
