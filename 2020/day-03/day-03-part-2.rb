#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

tree_map = input.split("\n")

def tree_counter(tree_map, x_inc, y_inc=1)
  x_pos = 0
  tree_map = tree_map.each_slice(y_inc).map(&:first)
  trees = tree_map.map do |line|
    tree = line[x_pos]=="#" ? 1 : 0
    x_pos += x_inc
    x_pos -= line.size if x_pos >= line.size
    tree
  end
  trees.sum
end

slopes = [ [1,1], [3,1], [5,1], [7,1], [1,2] ]
puts slopes.map{|x_inc, y_inc| tree_counter(tree_map, x_inc, y_inc)}.inject(:*)
