#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n").map{ | inst | inst.split(" ") }

aim = 0
depth = 0
horizontal = 0
input.each do | dir, i |
    i = i.to_i
    case (dir)
    when "forward"
        horizontal += i
        depth += aim * i
    when "down"
        aim += i
    when "up"
        aim -= i
    end
end

pp depth * horizontal