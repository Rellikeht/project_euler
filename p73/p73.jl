#!/usr/bin/env -S julia -O3

up = 1/2
down = 1/3

function fracs(d, up=1/2, down=1/3)
    num = 0
    for i in 1:d
        for j in i+1:d
            if gcd(i, j) != 1
                continue
            end
            f = i/j
            if f > down && f < up
                num += 1
                # println(i, ' ', j)
            end
        end
    end
    return num
end

@time println(fracs(12000))
