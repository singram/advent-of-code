#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

x_pos = 0
x_inc = 3

trees = input.split("\n").map do |line|
  tree = line[x_pos]=="#" ? 1 : 0
  x_pos += x_inc
  x_pos -= line.size if x_pos >= line.size
  tree
end

puts trees.sum
