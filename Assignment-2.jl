### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 3f13038e-7f3f-11eb-28bc-9fd513debe96
using DataFrames, HTTP, JSON, Dates, Statistics, TableIO, Plots

# ╔═╡ e1d3f870-7f3d-11eb-01eb-07d4e664462a
md"
#### Problem 1
"

# ╔═╡ e4af7a10-7f3d-11eb-3012-bb7d469a4ec5
begin
	df1 = DataFrame()
	df1.religion = ["Agnostic","Atheist","Buddhist","Catholic","Don't know/Refused", "Evangelical Prot", "Hindu", "Historically Black Prot", "Jehovah's Witness", "Jewish"]
	df1."<\$10k" = [27,12,27,418,15,575,1,228,20,19]
	df1."\$10-20k" = [34,27,21,617,14,869,9,244,27,19]
	df1."\$20-30k" = [60,37,30,732,15,1064,7,236,24,25]
	df1."\$30-40k" = [81,52,34,670,11,982,9,238,24,25]
	df1."\$40-50k" = [76,35,33,638,10,881,11,197,21,30]
	df1."\$50-75k" = [137,70,58,1116,35,1486,34,223,30,95]
	df1
end

# ╔═╡ 257bce2e-7f3f-11eb-2dc5-993c06d3423f
begin
	df1Stacked = sort(stack(df1,2:7))
	rename!(df1Stacked,:variable => :income, :value => :freq)
	df1Stacked
end

# ╔═╡ 3d73d5b0-7f43-11eb-0b59-31d96020602b
md"
#### Problem 2
"

# ╔═╡ 3f659390-7f43-11eb-0ef1-f5953bdb05ad
begin
	df2=DataFrame()
	id=[]
	which_year=[]
	which_month=[]
	element = []
	for i in 1:12
		push!(id,"MX17004")
		push!(which_year,2010)
		push!(which_month,Int(ceil(i/2)))
		if i%2==0
			push!(element,"tmin")
		else
			push!(element,"tmax")
		end
	end
	df2.id = id
	df2.year = which_year
	df2.month = which_month
	df2.element = element
	for j in 1:31
		d = []
		for i in 1:12
			if i%2!=0
				push!(d,rand(25:40))
			else
				push!(d,rand(20:25))
			end
		end
		df2.d = d
		rename!(df2,:d => :"d"*string(j))
	end
	for k in [33,34]
		df2[3,k] = missing
		df2[4,k] =missing 
	end
	i=35
	for j in [3,4,7,8,11,12]
		df2[j,i] =missing 
		df2[j,i] =missing
	end
	df2_1= coalesce.(df2, -9999)
	df2_1
end

# ╔═╡ afcc9c00-7f52-11eb-2f58-13d0bc3490c2
begin
	
	# df2 is the untidy dataframe. tidy_df2 is the tidy dataframe.
	# made a vector of required columns and added them to the dataframe.
	
	tidy_df2=DataFrame()
	Index =[]
	date=[]
	tmax=[]
	tmin=[]
	for i in 1:12
		for j in 1:31
			if df2_1[i,j+4] != -9999
				if i%2!=0
					push!(date,Date(df2_1[i,2],df2_1[i,3],j))
					push!(tmax,df2_1[i,j+4])
					push!(Index,df2_1[i,1])
				else
					push!(tmin,df2_1[i,j+4])
				end
			end
		end
	end
	tidy_df2.id=Index
	tidy_df2.date = date
	tidy_df2.tmax= tmax
	tidy_df2.tmin = tmin
	tidy_df2
end

# ╔═╡ 89c039e0-7f11-11eb-2e94-9d5fd606a81c
md"
#### Problem 3
"

# ╔═╡ be146320-7f15-11eb-3f70-09daebfbc5f0
begin
	df3 = DataFrame(year = Int[], artist = String[], time = String[], track = String[], date=Date[], week=Int[], rank=Int[])
	push!(df3,[  2000 , "2 Pac", "4:22","Baby Don't Cry" , Date(2000,2,26,) , 1 ,87])
	push!(df3, [ 2000 ,  "2 Pac", "4:22","Baby Don't Cry" , Date(2000,03,04) , 2 , 82 ])
	push!(df3,[  2000 , "2 Pac" , "4:22","Baby Don't Cry" , Date(2000,03,11) , 3 , 72 ]) 
	push!(df3, [ 2000 , "2 Pac" , "4:22","Baby Don't Cry" , Date(2000,03,18) , 4 , 77 ]) 
	push!(df3,[  2000 , "2 Pac" , "4:22","Baby Don't Cry" , Date(2000,03,25) , 5 , 87 ]) 
	push!(df3, [2000 , "2 Pac" , "4:22","Baby Don't Cry" , Date(2000,04,01) , 6 , 94 ])
	push!(df3,[  2000 , "2 Pac" , "4:22", "Baby Don't Cry" , Date(2000,04,08), 7 , 99]) 
	push!(df3, [ 2000 , "2Ge+her" , "3:15", "The Hardest Part Of ..." , Date(2000,09,02) , 1, 91 ])
	push!(df3, [ 2000 , "2Ge+her" , "3:15", "The Hardest Part Of ..." , Date(2000,09,09), 2 , 87]) 
	push!(df3,[  2000 , "2Ge+her" , "3:15","The Hardest Part Of ..." , Date(2000,09,16), 3, 92 ]) 
	push!(df3, [ 2000 , "3 Doors Down" , "3:53", "Kryptonite" , Date(2000,04,08) , 1 ,81 ])
	push!(df3, [ 2000 , "3 Doors Down" , "3:53", "Kryptonite" , Date(2000,04,15 ), 2 , 70 ]) 
	push!(df3, [ 2000 , "3 Doors Down" , "3:53", "Kryptonite" , Date(2000,04,22) , 3 , 68 ]) 
	push!(df3, [ 2000 , "3 Doors Down" , "3:53", "Kryptonite" , Date(2000,04,29 ), 4 , 67 ]) 
	push!(df3, [ 2000 , "3 Doors Down" , "3:53", "Kryptonite" , Date(2000,05,06) , 5 , 66 ])
	push!(df3, [ 2000 , "Aguilera, Christina", "4:00", "I Turn To You", Date(2000,04,15) , 1,50 ])
	push!(df3, [ 2000 , "Aguilera, Christina", "4:00", "I Turn To You", Date(2000,04,15) , 2,39 ])
	push!(df3, [ 2000 , "Aguilera, Christina", "4:00", "I Turn To You", Date(2000,04,15) , 3,30 ])
	push!(df3, [ 2000 , "Aguilera, Christina", "4:00", "I Turn To You", Date(2000,04,15) , 4,28 ])
	push!(df3, [ 2000 , "Aguilera, Christina", "4:00", "I Turn To You", Date(2000,04,15) , 5,21 ])
	push!(df3, [ 2000 , "Iglesias, Enrique ", "7:35", "Rhythm Divine", Date(1999,12,04) , 1,90 ])
	push!(df3, [ 2000 , "Iglesias, Enrique ", "7:35", "Rhythm Divine", Date(1999,12,04) , 2,84 ])
	push!(df3, [ 2000 , "Iglesias, Enrique ", "7:35", "Rhythm Divine", Date(1999,12,04) , 3,79 ])
	push!(df3, [ 2000 , "Iglesias, Enrique ", "7:35", "Rhythm Divine", Date(1999,12,04) , 4,67 ])
	push!(df3, [ 2000 , "Iglesias, Enrique ", "7:35", "Rhythm Divine", Date(1999,12,04) , 5,67 ])
	push!(df3, [ 2000 , "Madonna", "4:30","American Pie", Date(2000,02,19) , 1,43])
	push!(df3, [ 2000 , "Madonna", "4:30","American Pie", Date(2000,02,19) , 2,35])
	push!(df3, [ 2000 , "Madonna", "4:30","American Pie", Date(2000,02,19) , 3, 29 ])
	push!(df3, [ 2000 , "Lil Wayne","4:13",	"Tha Block Is Hot", Date(1999,12,04),1,99 ])
	push!(df3, [ 2000 , "Lil Wayne","4:13",	"Tha Block Is Hot", Date(1999,12,04),1,89 ])
	df3
end

# ╔═╡ b3fe9bd0-7f24-11eb-1671-a3f3ce40c42c
# made a column index unique to every track

begin	
	Id=[]
	push!(Id,1)
	count = 1
	for i in 2:30
		if df3[i,4]==df3[i-1,4]
			push!(Id,count)
		else
			count+=1
			push!(Id,count)
		end
	end
	df3.Id=Id
	df3
end

# ╔═╡ 0c7e8cb0-7f30-11eb-0482-9343bd7612af
#required dataframe 1

df3_1 = unique(df3[:,[8,2,4,3]],3)

# ╔═╡ 106f75f0-7f30-11eb-38de-93cbb7b6ebe1
#required dataframe 1

df3_2 = df3[:,[8,5,7]]

# ╔═╡ 8cbda232-7e9f-11eb-1d64-f5d495aee541
md"
#### Problem 4
"

# ╔═╡ 47a29b20-7ea3-11eb-1982-bdbdb8bfcff4
# loaded dataset into dataframe of julia
# converted dailyconfirmed, dailydeceased, dailyrecovered to integer and dateymd to date datatype.

begin
	d = JSON.Parser.parse(String(HTTP.get("https://api.covid19india.org/data.json").body))["cases_time_series"]
	df4 = reduce(vcat,DataFrame.(d))
	df4.dateymd = Date.(df4.dateymd, "yyyy-mm-dd")
	df4.months = [Dates.month(df4[i,5]) for i in 1:size(df4,1)]
	df4.year = [Dates.year(df4[i,5]) for i in 1:size(df4,1)]
	df4.dailyconfirmed = parse.([Int],df4[!,:dailyconfirmed])
	df4.dailydeceased = parse.([Int],df4[!,:dailydeceased])
	df4.dailyrecovered = parse.([Int],df4[!,:dailyrecovered])
	select!(df4, Not(:dateymd), Not(:dailyconfirmed), Not(:dailydeceased),Not(:dailyrecovered))
	df4
end

# ╔═╡ 78af6750-7f04-11eb-0339-d38866bee131
#grouped data wrt months and took sum of the total cases (confirmed, deceased and recovered) in a month)

begin
	gdf = groupby(df4, [:year,:months])
	combine(gdf,:dailyconfirmed=>(x->sum(x)),:dailydeceased=>(x->sum(x)),:dailyrecovered=>(x->sum(x)))
end

# ╔═╡ 412f51b0-7f30-11eb-0b6e-bf59ef8fb810
md"
#### Problem 5
"

# ╔═╡ 4349a630-7f30-11eb-3eb6-954629d73f87
begin
	df5 = df4[:,[10,1,2,3]]
	df5
end

# ╔═╡ 1b0ab130-7f32-11eb-010e-3f32d56e6670
begin
	confirmed_avg = []
	deceased_avg = []
	recovered_avg = []
	for i = 1:6
		push!(confirmed_avg, missing)
		push!(deceased_avg, missing)
		push!(recovered_avg, missing)
	end
	for i = 7:size(df4,1)
		push!(confirmed_avg, sum(df5[i-6:i,2])/7)
		push!(deceased_avg, sum(df5[i-6:i,3])/7)
		push!(recovered_avg, sum(df5[i-6:i,4])/7)
	end
end

# ╔═╡ 1d210380-7f31-11eb-25d1-41b5bed3ca56
begin
	df5.confirmed_avg=confirmed_avg
	df5.deceased_avg=deceased_avg
	df5.recovered_avg=recovered_avg
end

# ╔═╡ 0195ef92-7f40-11eb-03a7-97cabe38396d
plot(1:size(df4,1),df5.dailyconfirmed, label="Daily Data",title="Daily Data of 7 Days of Confirmed CoVid Positive People")

# ╔═╡ bd689222-7f6a-11eb-1faf-e7854bbb2be2
plot(1:size(df4,1),df5.confirmed_avg,label="Moving avg of 7 days",title="Moving Average of 7 Days of Confirmed CoVid Positive People")

# ╔═╡ e97060b0-7f41-11eb-0dcc-09f145d42819
plot(1:size(df4,1),df5.dailydeceased, label="Daily Data",title="Daily Data of 7 Days of Deceased CoVid Positive People")

# ╔═╡ ea6aa290-7f6a-11eb-00ea-57dc272ff871
plot(1:size(df4,1),df5.deceased_avg,label="Moving avg of 7 days",title="Moving Average of 7 Days of Deceased CoVid Positive People")

# ╔═╡ ea671cc0-7f41-11eb-37a6-c165cfb9ace4
plot(1:size(df4,1),df5.dailyrecovered, label="Daily Data",title="Daily Data of 7 Days of Recovered CoVid Positive People")

# ╔═╡ 146e8e30-7f6b-11eb-2203-23b981a39651
plot(1:size(df4,1),df5.recovered_avg,label="Moving avg of 7 days",title="Moving Average of 7 Days of Recovered CoVid Positive People")

# ╔═╡ Cell order:
# ╠═3f13038e-7f3f-11eb-28bc-9fd513debe96
# ╟─e1d3f870-7f3d-11eb-01eb-07d4e664462a
# ╟─e4af7a10-7f3d-11eb-3012-bb7d469a4ec5
# ╠═257bce2e-7f3f-11eb-2dc5-993c06d3423f
# ╟─3d73d5b0-7f43-11eb-0b59-31d96020602b
# ╠═3f659390-7f43-11eb-0ef1-f5953bdb05ad
# ╠═afcc9c00-7f52-11eb-2f58-13d0bc3490c2
# ╟─89c039e0-7f11-11eb-2e94-9d5fd606a81c
# ╠═be146320-7f15-11eb-3f70-09daebfbc5f0
# ╠═b3fe9bd0-7f24-11eb-1671-a3f3ce40c42c
# ╠═0c7e8cb0-7f30-11eb-0482-9343bd7612af
# ╠═106f75f0-7f30-11eb-38de-93cbb7b6ebe1
# ╟─8cbda232-7e9f-11eb-1d64-f5d495aee541
# ╠═47a29b20-7ea3-11eb-1982-bdbdb8bfcff4
# ╠═78af6750-7f04-11eb-0339-d38866bee131
# ╟─412f51b0-7f30-11eb-0b6e-bf59ef8fb810
# ╠═4349a630-7f30-11eb-3eb6-954629d73f87
# ╠═1b0ab130-7f32-11eb-010e-3f32d56e6670
# ╠═1d210380-7f31-11eb-25d1-41b5bed3ca56
# ╠═0195ef92-7f40-11eb-03a7-97cabe38396d
# ╠═bd689222-7f6a-11eb-1faf-e7854bbb2be2
# ╠═e97060b0-7f41-11eb-0dcc-09f145d42819
# ╠═ea6aa290-7f6a-11eb-00ea-57dc272ff871
# ╠═ea671cc0-7f41-11eb-37a6-c165cfb9ace4
# ╠═146e8e30-7f6b-11eb-2203-23b981a39651
