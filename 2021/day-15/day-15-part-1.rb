#!/usr/bin/env ruby

file_path = File.expand_path("../day-15-input.txt", __FILE__)
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
input = input.split("\n").map{ |line| line.split('').map(&:to_i) }

# Iterative function to find the minimum cost to traverse from the first cell to the last cell of a grid
#   By storing the minimum accumulated cost from 0,0 towards the final destination
def findMinCostIncrementOnly(cost)
    return 0 unless cost.size > 0
 
    width = cost[0].size
    depth = cost.size
    
    # path_cost[y][x] maintains the minimum cost to reach cell (y, x) from cell (0, 0)
    path_cost = Array.new(depth){ Array.new(width) }
 
    # fill the matrix in a top, down manner (0,0 top left convention)
    (0...depth).each do |y| # y
        (0...width).each do |x| 
            path_cost[y][x] = cost[y][x]
            if (y == 0 && x == 0 )
                # Solution should only count the cost of entering a space so remove cost of [0,0] the starting position
                path_cost[x][y] = 0
            elsif (y == 0 && x > 0) 
                # fill the first row (there is only one way to reach any cell in the first row from its adjacent left cell)
                path_cost[0][x] += path_cost[0][x - 1]
            elsif (x == 0 && y > 0) 
                # fill the first column (there is only one way to reach any cell in the first column from its adjacent top cell)
                path_cost[y][0] += path_cost[y - 1][0]
            elsif (y > 0 && x > 0) 
                # fill the rest with the matrix with the minimum value for any given point.
                # (there are two ways to reach any cell, from its adjacent left cell or adjacent top cell)
                path_cost[y][x] += [path_cost[y - 1][x], path_cost[y][x - 1]].min
            end
        end
    end
 
    # last cell of stores the minimum cost to reach destination cell from source cell (0, 0)
    return path_cost[depth - 1][width - 1];
end

# Useful links for Dijkstras algorithm.
# https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
# https://www.ericburden.work/blog/2021/12/16/advent-of-code-2021-day-15/
# https://judecapachietti.medium.com/dijkstras-algorithm-for-adjacency-matrix-in-python-a0966d7093e8
# https://blog.linkedin.com/2008/09/19/implementing-di
# https://medium.com/@felipeenne/dijkstras-algorithm-in-ruby-98a81cf81251
# https://www.programiz.com/dsa/dijkstra-algorithm

INFINITY = 1000

# Implementation of Dijskstras minimum graph path algorithm considering all 4 directions possible to navigate the map.
#  Note that the min_heap isn't a heap, just a sorted array but performs the same function of ordering nodes to pursue.
def findMinCostDijkstras(graph, start=[0,0])
    return 0 unless graph.size > 0
    width, depth = graph[0].size, graph.size
    visited    = Array.new(depth) {Array.new(width, false) }
    distance   = Array.new(depth) {Array.new(width, INFINITY) }
    prev_point = Array.new(depth) {Array.new(width, nil) }
    number_of_points, visited_count = width * depth, 0
    directions = [[0, 1], [1, 0], [-1, 0], [0, -1]]
    min_heap   = []
    
    distance[start[1]][start[0]] = 0
    min_heap << {dist_from_start: distance[start[1]][start[0]], x: start[1], y: start[0]}
    min_heap.sort!{|a,b| b[:dist_from_start] <=> a[:dist_from_start]}

    while visited_count < number_of_points
        # Pull the next point with the lowest cost to explore
        current_point = min_heap.pop
        directions.each do |direction_y, direction_x| 
            new_location = {x: current_point[:x] + direction_x, y: current_point[:y] + direction_y }
            # Consider only points on the map not yet visited
            if new_location[:x].between?(0, width-1) && new_location[:y].between?(0, depth-1) && !visited[new_location[:y]][new_location[:x]]
                dist_to_new_point = current_point[:dist_from_start] + graph[new_location[:y]][new_location[:x]]
                if dist_to_new_point < distance[new_location[:y]][new_location[:x]]
                    distance[new_location[:y]][new_location[:x]] = dist_to_new_point
                    prev_point[new_location[:y]][new_location[:x]] = [current_point[:y], current_point[:x]]
                    min_heap << {dist_from_start: dist_to_new_point, x: new_location[:x], y: new_location[:y]}
                    min_heap.sort!{|a,b| b[:dist_from_start] <=> a[:dist_from_start]}
                end
            end
        end
        # After processing all possible directions consider the node visited.
        visited[current_point[:y]][current_point[:x]] = true
        visited_count += 1    
    end
    return distance[depth - 1][width - 1];
end

pp findMinCostDijkstras(input)
