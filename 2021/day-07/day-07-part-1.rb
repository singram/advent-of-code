#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

crab_positions   = input.split(',').map(&:to_i)

class Array
    def median
        sorted = self.sort # required
        midpoint = self.length / 2 # integer division
        if self.length.even?
            # median is mean of two values around the midpoint
            sorted[midpoint-1, 2].sum / 2.0
        else
            sorted[midpoint]
        end
    end
end

def calc_fuel_for_position(crab_positions, target_position)
    crab_positions.map{|p| (p-target_position).abs}.sum
end

target_position = crab_positions.median.to_i

pp calc_fuel_for_position(crab_positions, target_position)