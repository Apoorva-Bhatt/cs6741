### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ a448c3d0-8d59-11eb-193f-d5d697e256d1
using Random, Distributions, Calculus

# ╔═╡ 7ea7a0a0-8d5a-11eb-1731-17e148b2d8b6
using Plots, QuadGK, HTTP, JSON, Distances

# ╔═╡ 91224f50-8d5a-11eb-3656-5f25c2ef4131
using DataFrames, Dates, CSV, StatsPlots, LaTeXStrings

# ╔═╡ 81d5fd30-8d5a-11eb-258a-8f2de8b2572c
gr()

# ╔═╡ 68c5f930-8d5a-11eb-3fd0-873ad6fb8d2d
md"### Problem 1"

# ╔═╡ 70059f30-92b3-11eb-0919-c5163b8e23e6
function KL_div(p,q)
	f(x) = p(x)*log(p(x)/q(x))
	return quadgk(f,-35,35)
end

# ╔═╡ 67597f90-956b-11eb-0673-83a7815375b9
begin
	result = []
	for i in 1:5
		p(x) = pdf(TDist(i),x)
		q(x)=pdf(Normal(0,1),x)
		push!(result,KL_div(p,q))
	end
end

# ╔═╡ b17a9390-951e-11eb-338f-45c2d862530d
result

# ╔═╡ 47f9fdf0-9520-11eb-222a-83b17aebe5aa
#problem 2

# ╔═╡ e33002fe-9557-11eb-32be-018fd978d11d
begin
	function sum_pdf(x,n)
		sum = 0
		for k in 0:n
			sum+=(-1)^k*binomial(n,k)*(x-k)^(n-1)*sign(x-k)
		end
		sum=sum/(2*factorial(n-1))
		return sum
	end
end

# ╔═╡ b8da2c2e-956a-11eb-113f-1926f5232c4a
Q(x,n) = pdf(Normal(n/2,sqrt(n/12),x))

# ╔═╡ d9e87970-956c-11eb-2ab7-75b12b67dfef
fun(x) = sum_pdf(x,2)*log(sum_pdf(x,2)/Q(x,2)) 

# ╔═╡ dadd60c0-956c-11eb-058e-c506f8289681
plot(fun)

# ╔═╡ 03992e40-9568-11eb-145d-3d460b853e1c
begin
	arr = []
	for i in 2:10
		fun(x) = sum_pdf(x,i)*log(sum_pdf(x,i)/Q(x,i)) 
	end
end

# ╔═╡ ac27a222-92d5-11eb-2274-9b882e353b12
md"### Problem 3"

# ╔═╡ bbcf7000-956d-11eb-0f89-11700195a01e
md"Here is the data, 10^5 samples of Poisson(0.75)such that the distribution of the data is distinctly right skewed (skewness>1), but mean is smaller than the median."

# ╔═╡ dbe87d40-92fd-11eb-0eaa-9b87ef6be39d
g = rand(Poisson(0.75), 100000)

# ╔═╡ f1d8cab0-92fd-11eb-1184-a7391fcea66b
mean(g)

# ╔═╡ 54ce8060-92fe-11eb-094f-639cd59135d4
median(g)

# ╔═╡ a3588cd0-92fe-11eb-30b5-43d6cc518d1e
begin
	histogram(g)
	scatter!([mean(g)],[0], label = "mean")
	scatter!([median(g)],[0], label = "median")
	scatter!([mode(g)],[0], label = "mode")
end

# ╔═╡ 5a10c8d0-92fe-11eb-3392-ad4631c14320
skewness(g)

# ╔═╡ 20dcbe40-9301-11eb-1c92-a5f7e90bd821
md" ### Problem 4"

# ╔═╡ 2c27d370-9301-11eb-3082-6520004c2ecc
begin
	Random.seed!(100)
	a = []
	for i in 1:10000
		b = rand(Uniform(0,1),30)
		push!(a, maximum(b)-minimum(b))
	end
	histogram(a)
	plot!([mean(a),mean(a)],[0,600],label = false,line=(2,:red))
	plot!([median(a),median(a)],[0,600],label = false,line=(2,:white))
	plot!([mode(a),mode(a)],[0,600],label = false,line=(2,:pink))
end

# ╔═╡ f64f73d0-9570-11eb-3618-43050f6fbfbc
md"## Problem 5"

# ╔═╡ fecb8a80-9570-11eb-2c75-41b91c13c6da
md" In Google Doc"

# ╔═╡ 1c831630-9303-11eb-3097-27f7cf989288
md" ### Problem 6"

# ╔═╡ 0e88bf80-9303-11eb-17c2-c1294eedd1f5
begin
	df = DataFrame(CSV.File(HTTP.get("https://api.covid19india.org/csv/latest/states.csv").body))
	week_year=[]
	for i in 1:size(df,1)
		push!(week_year,string(Dates.week(df[i,1])) * "-" * string(Dates.year(df[i,1])))
	end
	df.week_year = week_year
	dfn = coalesce.(unstack(combine(groupby(df, [:State,:week_year]),:Confirmed=>(x->sum(x)) => :Cases), :week_year,:State, :Cases), 0)
	select!(dfn, Not(:India))
	dfn
end

# ╔═╡ a492bb30-9456-11eb-1783-71dcffb227e1
md" ## Problem 7"

# ╔═╡ 9d3109f0-956e-11eb-119b-3390e63490dc
begin
	#required functions for normal and student's t distributions
	onesidedtail_normal(x) = quantile(Normal(0,1), (100-x)/100)
	onesidedtail_TDist(x) = quantile(TDist(10), (100-x)/100)
	N_fun(x) = pdf(Normal(0,1),x)
	T_fun(x) = pdf(TDist(10),x)
end

# ╔═╡ ae429c80-948e-11eb-196c-232251e25576
begin
	plot(Normal(0,1), line=(5, :purple), fill=(0, :red, 0.2), label="Normal")
	plot!([onesidedtail_normal(95),onesidedtail_normal(95)],[0,N_fun(onesidedtail_normal(95))],line=(2,:brown))
end

# ╔═╡ 91e59390-9492-11eb-0d10-931c3ece03c0
begin
	plot(TDist(10), line=(5, :green), fill=(0, :green, 0.2), label="Student's T-Distribution")
	plot!([onesidedtail_TDist(95),onesidedtail_TDist(95)],[0,T_fun(onesidedtail_TDist(95))],line=(2,:blue))
end

# ╔═╡ Cell order:
# ╠═a448c3d0-8d59-11eb-193f-d5d697e256d1
# ╠═7ea7a0a0-8d5a-11eb-1731-17e148b2d8b6
# ╠═91224f50-8d5a-11eb-3656-5f25c2ef4131
# ╠═81d5fd30-8d5a-11eb-258a-8f2de8b2572c
# ╟─68c5f930-8d5a-11eb-3fd0-873ad6fb8d2d
# ╠═70059f30-92b3-11eb-0919-c5163b8e23e6
# ╠═67597f90-956b-11eb-0673-83a7815375b9
# ╠═b17a9390-951e-11eb-338f-45c2d862530d
# ╠═47f9fdf0-9520-11eb-222a-83b17aebe5aa
# ╠═e33002fe-9557-11eb-32be-018fd978d11d
# ╠═b8da2c2e-956a-11eb-113f-1926f5232c4a
# ╠═d9e87970-956c-11eb-2ab7-75b12b67dfef
# ╠═dadd60c0-956c-11eb-058e-c506f8289681
# ╠═03992e40-9568-11eb-145d-3d460b853e1c
# ╟─ac27a222-92d5-11eb-2274-9b882e353b12
# ╟─bbcf7000-956d-11eb-0f89-11700195a01e
# ╠═dbe87d40-92fd-11eb-0eaa-9b87ef6be39d
# ╠═f1d8cab0-92fd-11eb-1184-a7391fcea66b
# ╠═54ce8060-92fe-11eb-094f-639cd59135d4
# ╠═a3588cd0-92fe-11eb-30b5-43d6cc518d1e
# ╠═5a10c8d0-92fe-11eb-3392-ad4631c14320
# ╟─20dcbe40-9301-11eb-1c92-a5f7e90bd821
# ╠═2c27d370-9301-11eb-3082-6520004c2ecc
# ╟─f64f73d0-9570-11eb-3618-43050f6fbfbc
# ╟─fecb8a80-9570-11eb-2c75-41b91c13c6da
# ╟─1c831630-9303-11eb-3097-27f7cf989288
# ╠═0e88bf80-9303-11eb-17c2-c1294eedd1f5
# ╟─a492bb30-9456-11eb-1783-71dcffb227e1
# ╠═9d3109f0-956e-11eb-119b-3390e63490dc
# ╠═ae429c80-948e-11eb-196c-232251e25576
# ╠═91e59390-9492-11eb-0d10-931c3ece03c0
