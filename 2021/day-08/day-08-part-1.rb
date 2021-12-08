#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

# segment_count = {
#     0 => 6,
#     1 => 2, # Unique
#     2 => 5,
#     3 => 5,
#     4 => 4, # Unique
#     5 => 5,
#     6 => 6,
#     7 => 3, # Unique
#     8 => 7, # Unique
#     9 => 6
# }

outputs   = input.split("\n").map{|line| line.split(" | ")[1].split(" ")}

pp outputs.flatten.select{|digit| [2,4,3,7].include?(digit.size)}.count