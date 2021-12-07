#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

crab_positions   = input.split(',').map(&:to_i).sort!

# sum of the consecutive integers
def sum_of_integers(distance)
    distance = distance.abs
    ((distance+1)*distance)/2
end

def calc_fuel_for_position(crab_positions, target_position)
    crab_positions.map{|p| sum_of_integers(p-target_position)}.sum
end

max_pos = crab_positions.max
min_pos = crab_positions.min

# Find lowest fuel position using binary search on the sorted crab positions
while min_pos < max_pos
    mid_pos = (min_pos + max_pos) / 2
    max_pos_fuel = calc_fuel_for_position(crab_positions, max_pos)
    min_pos_fuel = calc_fuel_for_position(crab_positions, min_pos)
    if max_pos_fuel > min_pos_fuel
        max_pos = mid_pos
    else
        min_pos = mid_pos
    end
end

pp calc_fuel_for_position(crab_positions, min_pos)
