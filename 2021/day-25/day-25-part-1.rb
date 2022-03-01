#!/usr/bin/env ruby

file_path = File.expand_path("../day-25-input.txt", __FILE__)
input     = File.read(file_path)
# input="v...>>.vv>
# .vv>>.vv..
# >>.>v>...v
# >>v>>.>.v.
# v>v.vv.v..
# >.>>..v...
# .vv..>.>v.
# v.v..>>v.v
# ....v..v.>"
SPACE = '.'
CUC1  = '>'
CUC2  = 'v'

map       = input.split("\n").map{|line| line.split('')}

MAPX_SIZE = map[0].size
MAPY_SIZE = map.size

new_map   = Marshal.load( Marshal.dump(map) )

1000.times do |i|
    old_map   = Marshal.load( Marshal.dump(new_map) )
    # Move east heading sea cucumbers
    (0...MAPY_SIZE).each do |y|
        (0...MAPX_SIZE).each do |x|
            if old_map[y][x] == CUC1
                if new_map[y][(x+1)%MAPX_SIZE] == SPACE
                    if (x+1)%MAPX_SIZE>0 || old_map[y][(x+1)%MAPX_SIZE] != CUC1
                        new_map[y][x] = SPACE
                        new_map[y][(x+1)%MAPX_SIZE] = CUC1
                    else
                        new_map[y][x] = CUC1
                    end
                else
                    new_map[y][x] = CUC1
                end
            end
        end
    end
    # Move south heading sea cucumbers
    (0...MAPX_SIZE).each do |x|
        (0...MAPY_SIZE).each do |y|
            if old_map[y][x] == CUC2
                if new_map[(y+1)%MAPY_SIZE][x] == SPACE
                    if (y+1)%MAPY_SIZE>0 || old_map[(y+1)%MAPY_SIZE][x] != CUC2 #&& old_map[(y+1)%MAPY_SIZE][x] != CUC2
                        new_map[y][x] = SPACE
                        new_map[(y+1)%MAPY_SIZE][x] = CUC2
                    else
                        new_map[y][x] = CUC2
                    end
                else
                    new_map[y][x] = CUC2
                end
            end
        end
    end
    # pp new_map.map(&:join)
    if (old_map == new_map )
        pp "STABILIZATION ACHIEVED! Step #{i+1}"
        break
    end
end
