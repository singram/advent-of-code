#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

fish_tracker = Array.new(9,0)

input.split(',').map(&:to_i).each{ |i| fish_tracker[i] += 1 }

days = 256

days.times do
    spawning_fish = fish_tracker.shift
    fish_tracker[6] += spawning_fish
    fish_tracker[8]  = spawning_fish
end

pp fish_tracker.sum
