#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

cave = input.split("\n").map{|line| line.split('').map(&:to_i)}

def find_low_points(cave)
    cave_x_max = cave[0].size
    cave_y_max = cave.size
    
    low_points = []
    (0...cave_y_max).each do |y|
        (0...cave_x_max).each do |x|
            value = cave[y][x]
            next if value == 9
            next if y > 0            && cave[y-1][x] < value
            next if y < cave_y_max-1 && cave[y+1][x] < value
            next if x > 0            && cave[y][x-1] < value
            next if x < cave_x_max-1 && cave[y][x+1] < value
            low_points << [y,x]
        end
    end
    low_points
end

def find_basin(cave, point)
    cave_x_max = cave[0].size
    cave_y_max = cave.size
    y, x = point[0], point[1]
    points = []
    unless [9, '#'].include?(cave[y][x])
        cave[y][x] = '#'
        points << [point]
        points << find_basin(cave, [y-1, x]) if y > 0
        points << find_basin(cave, [y+1, x]) if y < cave_y_max-1
        points << find_basin(cave, [y, x-1]) if x > 0            
        points << find_basin(cave, [y, x+1]) if x < cave_x_max-1
    end

    points.flatten(1)
end

# Find  coordinates for basins originating from each low point
basins = find_low_points(cave).map{|low_point| find_basin(cave, low_point)}

# Find 3 larges basins and multiply
pp basins.map(&:size).sort.last(3).inject(:*)
