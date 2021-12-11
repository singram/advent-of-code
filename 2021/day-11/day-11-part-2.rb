#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

octopi_map = input.split("\n").map{ |line| line.split('').map(&:to_i) }

def unresolved_flashes?(octopi_map, flashed_map)
    (0...octopi_map.size).each do |y|
        (0...octopi_map[0].size).each do |x|
            return true if octopi_map[y][x] > 9 && !flashed_map[y][x]
        end
    end
    false
end

def step(octopi_map)
    # increment by 1
    octopi_map = octopi_map.map{ |line| line.map{ |octo| octo += 1} }

    # Cascade flashing octopi
    flashed_map = Array.new(octopi_map.size) { Array.new(octopi_map[0].size) { false } }
    while unresolved_flashes?(octopi_map, flashed_map)
        map_x_max = octopi_map[0].size - 1
        map_y_max = octopi_map.size - 1
        (0...octopi_map.size).each do |y|
            (0...octopi_map[0].size).each do |x|
                if octopi_map[y][x] > 9 && !flashed_map[y][x]
                    octopi_map[y+1][x-1] += 1 if y < map_y_max && x > 0
                    octopi_map[y+1][x+0] += 1 if y < map_y_max 
                    octopi_map[y+1][x+1] += 1 if y < map_y_max && x < map_x_max
                    octopi_map[y+0][x-1] += 1 if x > 0
                    octopi_map[y+0][x+1] += 1 if x < map_x_max
                    octopi_map[y-1][x-1] += 1 if y > 0 && x > 0
                    octopi_map[y-1][x+0] += 1 if y > 0
                    octopi_map[y-1][x+1] += 1 if y > 0 && x < map_x_max
                    flashed_map[y][x] = true
                end
            end
        end
    end

    # Reset flashed octopi to 0
    flash_count = 0
    (0...octopi_map.size).each do |y|
        (0...octopi_map[0].size).each do |x|
            if octopi_map[y][x] > 9
                octopi_map[y][x] = 0 
                flash_count += 1
            end
        end
    end
    return octopi_map, flash_count
end

loop_counter = 0
1000.times do
    octopi_map, x = step(octopi_map)
    loop_counter += 1
    break if octopi_map.flatten.all?{|octo| octo == 0}
end
pp loop_counter

