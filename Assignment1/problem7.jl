### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ cb6cd500-7413-11eb-0722-8d1f8efa6601
using Distributions, Random

# ╔═╡ c1c4d690-7415-11eb-07e2-e51c941a36f4
begin
	using Plots
	pyplot()
end

# ╔═╡ dcc136e0-7439-11eb-19f0-dbdf99ea6a7a


# ╔═╡ 5f5d1af0-7413-11eb-311f-27dc2ae36aa8
function f(p)
	res = 0
	for _ in 1:10000
		a = []
		for _ in 1:20
			push!(a,rand(Bernoulli(1-p)))
			if (count(a.== 0)*-1+count(a.==1)+10)==0
				res +=1
			break
			end
		end
	end
	res/10000
end

# ╔═╡ 30e479d0-7444-11eb-38b0-abdd89cfdf74
p = collect(LinRange(0,1,11))

# ╔═╡ 3232f2d0-7444-11eb-2b0a-abc6e084daec


# ╔═╡ d47ae090-7415-11eb-3356-13cd7ca75032
plot(f,0,1)

# ╔═╡ Cell order:
# ╠═dcc136e0-7439-11eb-19f0-dbdf99ea6a7a
# ╠═cb6cd500-7413-11eb-0722-8d1f8efa6601
# ╠═5f5d1af0-7413-11eb-311f-27dc2ae36aa8
# ╠═30e479d0-7444-11eb-38b0-abdd89cfdf74
# ╠═3232f2d0-7444-11eb-2b0a-abc6e084daec
# ╠═c1c4d690-7415-11eb-07e2-e51c941a36f4
# ╠═d47ae090-7415-11eb-3356-13cd7ca75032
