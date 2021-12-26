#!/usr/bin/env ruby

file_path = File.expand_path("../day-21-input.txt", __FILE__)
input     = File.read(file_path)

positions = input.split("\n").map{|line| line.split(' ')[-1].to_i - 1}
scores = Array.new(positions.size){0}

@d100 = 0

def role_3_times
    number = (3*@d100) + 1 + 2 + 3
    @d100 += 3
    number
end

(0...positions.size).cycle do |p|
    moves = role_3_times
    positions[p] += moves
    positions[p] = positions[p] % 10 if positions[p] > 9 
    scores[p] += positions[p] + 1
    break if scores[p] >= 1000
end

pp scores.min * @d100
