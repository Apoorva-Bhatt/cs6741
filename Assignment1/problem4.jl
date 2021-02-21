### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ e169cf42-73a8-11eb-099e-73370c4cd9bd
using Random, Distributions

# ╔═╡ 770067a0-73a7-11eb-2350-bb51c6aca123
# Problem 4

# ╔═╡ ad8fd050-73aa-11eb-249d-5178b0581922
begin
	Random.seed!(1)
	password = randstring(['A':'Z'; 'a':'z'; '0':'9';'~'; '!'; '@'; '#'; '$'; '%'; '^'; '&'; '*'; '('; ')'; '_'; '+'; '='; '-'; '`'], 8)
	res = 0
	n = 10^6
	for _ in 1:n
		c = 0
		hack = randstring(['A':'Z'; 'a':'z'; '0':'9';'~'; '!'; '@'; '#'; '$'; '%'; '^'; '&'; '*'; '('; ')'; '_'; '+'; '='; '-'; '`'], 8)
		for i in 1:8
			if hack[i]==password[i]
				c +=1
			end
		end
		if c>=2
			res +=1
		end
	end
	res/n
end

# ╔═╡ Cell order:
# ╠═770067a0-73a7-11eb-2350-bb51c6aca123
# ╠═e169cf42-73a8-11eb-099e-73370c4cd9bd
# ╠═ad8fd050-73aa-11eb-249d-5178b0581922
