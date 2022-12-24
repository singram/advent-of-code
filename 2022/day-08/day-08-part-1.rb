#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

tree_height_map = input.split("\n").map{|line| line.split('').map(&:to_i)}
WIDTH = tree_height_map[0].size
HEIGHT = tree_height_map.size
tree_visible_map = Array.new(HEIGHT) { Array.new(WIDTH, false) }

# Rotates a nested arrary clockwise
def rotate_clockwise(arr)
    arr.transpose.map(&:reverse)
end

# Test each row from left to right until the tallest tree is hit.
# Rotate the map 4 times to test all sides.
4.times do
    tree_height_map.each_with_index do |line, j|
        max_height = line.max
        current_height = -1
        line.each_with_index do |height, i|
            if height > current_height
                current_height = height
                tree_visible_map[j][i] = true
            end
            break if current_height == max_height
        end
    end

    tree_height_map = rotate_clockwise(tree_height_map)
    tree_visible_map = rotate_clockwise(tree_visible_map)
end

# pp tree_height_map
# pp tree_visible_map
pp tree_visible_map.flatten.count(true)
