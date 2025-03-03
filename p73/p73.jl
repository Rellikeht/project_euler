#!/usr/bin/env -S julia -O3

const default_up = 1//2
const default_down = 1//3

function fracs(
    d::Int,
    up::Float64=Float64(default_up),
    down::Float64=Float64(default_down)
)::Int
    num::Int = 0
    for i in 1:d
        for j in i+1:d
            if gcd(i, j) != 1
                continue
            end
            f::Float64 = i/j
            if f > down && f < up
                num += 1
            end
        end
    end
    return num
end
_ = fracs(2)
_ = fracs(40)

@time println(fracs(12000))

function fracs2(
    d::Int,
    up::Float64=Float64(default_up),
    down::Float64=Float64(default_down)
)::Int
    num::Int = 0
    for i in 1:d
        for j in i+1:d
            f::Float64 = i/j
            if f >= up
                continue
            elseif f <= down
                break
            end
            if gcd(i, j) != 1
                continue
            end
            num += 1
        end
    end
    return num
end
_ = fracs2(2)
_ = fracs2(40)

@time println(fracs2(12000))

function fracs3(
    d::Int,
    up::Rational{Int}=default_up,
    down::Rational{Int}=default_down
)::Int
    num::Int = 0
    upf = Float64(up)
    downf = Float64(down)
    for i in 1:d
        for j in i+1:d
            f::Float64 = i/j
            if f >= upf
                continue
            elseif f <= downf
                break
            end
            if gcd(i, j) != 1
                continue
            end
            num += 1
        end
    end
    return num
end
_ = fracs3(2)
_ = fracs3(40)

@time println(fracs3(12000))
