#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

require 'matrix'
vectors = input.split("\n").map{ |l| l.match(/(\d+),(\d+) -> (\d+),(\d+)/).captures.map(&:to_i)}

coord_map = {}

vectors.each do |coordinates|
    start_v = Vector[*coordinates.shift(2)]
    end_v   = Vector[*coordinates.shift(2)]
    step_v  = (end_v - start_v).normalize.round

    while start_v != end_v do
        coord_map[start_v] ||= 0
        coord_map[start_v] += 1
        start_v += step_v
    end
    coord_map[start_v] ||= 0
    coord_map[start_v] += 1
end

pp coord_map.select{ |k,v| v > 1}.count