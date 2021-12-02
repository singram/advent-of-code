#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n").map{ | inst | inst.split(" ") }

depth = 0
horizontal = 0
input.each do | dir, i |
    i = i.to_i
    case (dir)
    when "forward"
        horizontal += i
    when "down"
        depth += i
    when "up"
        depth -= i
    end
end

pp depth * horizontal
