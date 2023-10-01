#!/bin/julia

function sieve(num :: UInt64) :: Vector{UInt64}
	amount :: UInt64 = 1
	ttable = repeat([true], num)

	for i = 4:2:num+1
		ttable[i-1] = false
	end

	for i = 3:2:num+1
		if ttable[i-1]
			amount += 1
			for j = i^2:i<<1:num+1
				ttable[j-1] = false
			end
		end
	end

	cur :: UInt64 = 2
	retval = Vector{UInt64}(undef, amount)
	n :: UInt64 = 1

	for i = ttable
		if i
			retval[n] = cur
			n += 1
		end
		cur += 1
	end

	return retval
end

function numOfFacts(num :: UInt64, primes :: Vector{UInt64})
	divs = 1
	p = 0

	while num > 1
		amount = 1
		p += 1
		pr = primes[p]

		while num % pr == 0
			amount += 1
			num /= pr
		end

		if amount > 1
			divs *= amount
		end
	end
	return divs
end

#primes = sieve(UInt64(1000000))

function minFacts(num :: UInt64)
	primes = sieve(UInt64(num^2))
	nfacts :: UInt64 = 1
	cnum :: UInt64 = 1
	i :: UInt64 = 2

	while nfacts <= num
		cnum += i
		i += 1
		nfacts = numOfFacts(cnum, primes)
	end
	return cnum
end

#token = split(readline(), " ")[begin]
#if length(token) > 0
#	amount = parse(UInt64, token)
#else
#	amount = 100
#end

amount = parse(UInt64, split(readline(), " ")[begin])
#println(sieve(amount))
#t1 = time()
println(minFacts(amount))
#println(time()-t1)
