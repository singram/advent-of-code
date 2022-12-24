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

HEAD = 0
TAIL = 9
start = Vector[0,0]

knots = Array.new(10, Vector[0,0] )

tail_trail = [start]

def calc_trailing_knot(leading_knot, trailing_knot)
    diff = leading_knot - trailing_knot
    if (diff[0].abs <= 1 && diff[1].abs <= 1)
        # Tail and head are adjacent or overlapping.  Do nothing.
    else        
        trailing_knot += VEC['U'] if diff[1] > 0
        trailing_knot += VEC['D'] if diff[1] < 0
        trailing_knot += VEC['L'] if diff[0] < 0
        trailing_knot += VEC['R'] if diff[0] > 0
    end
    trailing_knot
end

input.split("\n").each do |line|
    (dir, count) = line.split(' ')
    count.to_i.times do
        knots[HEAD] += VEC[dir]
        (0..9).each_cons(2).to_a.each do |leading, trailing|
            new_trailing_knot = calc_trailing_knot(knots[leading], knots[trailing])
            if new_trailing_knot != knots[trailing]
                knots[trailing] = new_trailing_knot
            else
                break
            end
        end
        tail_trail << knots[TAIL]
    end
end

# pp tail_trail
pp tail_trail.uniq.count
