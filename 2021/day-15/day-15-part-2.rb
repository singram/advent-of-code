#!/usr/bin/env ruby

file_path = File.expand_path('day-15-input.txt', __dir__)
input     = File.read(file_path)
# input ="1163751742
# 1381373672
# 2136511328
# 3694931569
# 7463417111
# 1319128137
# 1359912421
# 3125421639
# 1293138521
# 2311944581
# "
input = input.split("\n").map { |line| line.split('').map(&:to_i) }
width = input[0].size
depth = input.size

# Expand width 4 times, incrementing on the last block
4.times do
  input.map! { |row| row + row.slice(-width, width).map { |i| (i + 1) > 9 ? 1 : (i + 1) } }
end

# Expand depth 4 times, incrementing on the last block
4.times do
  input += input.slice(-depth, depth).map { |row| row.map { |i| (i + 1) > 9 ? 1 : (i + 1) } }
end

INFINITY = 5000

# Implementation of Dijskstras minimum graph path algorithm considering all 4 directions possible to navigate the map.
#  Note that the min_heap isn't a heap, just a sorted array but performs the same function of ordering nodes to pursue.
def find_min_cost_dijkstras(graph, start = [0, 0])
  return 0 if graph.empty?

  width = graph[0].size
  depth = graph.size
  visited    = Array.new(depth) { Array.new(width, false) }
  distance   = Array.new(depth) { Array.new(width, INFINITY) }
  prev_point = Array.new(depth) { Array.new(width, nil) }
  number_of_points = width * depth
  visited_count = 0
  directions = [[0, 1], [1, 0], [-1, 0], [0, -1]]
  min_heap   = []

  distance[start[1]][start[0]] = 0
  min_heap << { dist_from_start: distance[start[1]][start[0]], x: start[1], y: start[0] }
  min_heap.sort! { |a, b| b[:dist_from_start] <=> a[:dist_from_start] }

  while visited_count < number_of_points
    # Pull the next point with the lowest cost to explore
    current_point = min_heap.pop
    directions.each do |direction_y, direction_x|
      new_location = { x: current_point[:x] + direction_x, y: current_point[:y] + direction_y }
      # Consider only points on the map not yet visited
      next unless new_location[:x].between?(0, width - 1) &&
                  new_location[:y].between?(0, depth - 1) &&
                  !visited[new_location[:y]][new_location[:x]]

      dist_to_new_point = current_point[:dist_from_start] + graph[new_location[:y]][new_location[:x]]
      next unless dist_to_new_point < distance[new_location[:y]][new_location[:x]]

      distance[new_location[:y]][new_location[:x]] = dist_to_new_point
      prev_point[new_location[:y]][new_location[:x]] = [current_point[:y], current_point[:x]]
      min_heap << { dist_from_start: dist_to_new_point, x: new_location[:x], y: new_location[:y] }
    end
    # PERFORMANC BOTTLENECK.  Performing a array sort is always going to be slower than inserting
    # an element into an ordered tree using a proper min_heap structure
    min_heap.sort! { |a, b| b[:dist_from_start] <=> a[:dist_from_start] }
    # After processing all possible directions consider the node visited.
    visited[current_point[:y]][current_point[:x]] = true
    visited_count += 1
  end
  distance[depth - 1][width - 1]
end

pp find_min_cost_dijkstras(input)
