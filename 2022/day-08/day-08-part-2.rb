#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

tree_height_map = input.split("\n").map{|line| line.split('').map(&:to_i)}
WIDTH = tree_height_map[0].size
HEIGHT = tree_height_map.size
tree_value_map = Array.new(HEIGHT) { Array.new(WIDTH, nil) }

Y = 0
X = 1

VEC = {
    UP:    [-1,  0],
    DOWN:  [ 1,  0],
    LEFT:  [ 0, -1],
    RIGHT: [ 0,  1]
}

# Iterate over every position recording score.
# Note.  There are more efficient ways to do this with simply scanning a
# row in one direction and recording all values on a line for a given vector then multiplying 
# at the end.
tree_height_map.each_with_index do |line, j|
    line.each_with_index do |height, i|
        start_height = tree_height_map[j][i]
        tree_value_map[j][i] = VEC.keys.map do |dir|
            position = [j,i]
            count = 0
            while true
                position = [position[Y] + VEC[dir][Y], position[X] + VEC[dir][X]]
                break unless position[Y].between?(0, HEIGHT-1) && position[X].between?(0, WIDTH-1)
                count += 1
                break if tree_height_map[position[Y]][position[X]] >= start_height           
            end
            count
        end.inject(:*)
    end
end

#  pp tree_height_map
#  pp tree_value_map
 pp tree_value_map.map(&:max).max
