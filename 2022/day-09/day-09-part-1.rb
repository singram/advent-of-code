#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

# input = "R 4
# U 4
# L 3
# D 1
# R 4
# D 1
# L 5
# R 2"
require 'matrix'

VEC = {
    #           x, y
    'U' => Vector[  0, 1],
    'D' => Vector[  0,-1],
    'L' => Vector[ -1, 0],
    'R' => Vector[  1, 0]
}

head = Vector[0,0]
tail = Vector[0,0]

tail_trail = [tail]

input.split("\n").each do |line|
    (dir, count) = line.split(' ')
    count.to_i.times do
        head += VEC[dir]
        diff = head - tail
        if (diff[0].abs <= 1 && diff[1].abs <= 1)
            # Tail and head are adjacent or overlapping.  Do nothing.
        else        
            tail += VEC['U'] if diff[1] > 0
            tail += VEC['D'] if diff[1] < 0
            tail += VEC['L'] if diff[0] < 0
            tail += VEC['R'] if diff[0] > 0
        end
        tail_trail << tail
    end
end

# pp tail_trail
pp tail_trail.uniq.count