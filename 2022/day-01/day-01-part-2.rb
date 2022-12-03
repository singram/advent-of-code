#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)


#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n").map(&:to_i)

elves = [0]
input.each do |cal|
    cal >0 ? elves[0]+=cal : elves.unshift(0)
end

pp elves.sort.last(3).sum