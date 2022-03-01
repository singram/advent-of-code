#!/usr/bin/env ruby

file_path = File.expand_path("../day-22-input.txt", __FILE__)
input     = File.read(file_path)

OFF = 0
ON  = 1
CUBE_RANGE = -50..50

insts = input.split("\n").map{|line| line.split(' ') }
insts = insts.map{|line| [line[0] == 'on' ? ON : OFF, line[1].match(/x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/).captures.map(&:to_i)]}

class Range 
    def overlaps?(other)
        self.cover?(other.first) || other.cover?(self.first)
    end
end

class Cube 
    attr_accessor :x_rng, :y_rng, :z_rng
    def initialize(x1,x2,y1,y2,z1,z2)
        self.x_rng = x1..x2
        self.y_rng = y1..y2
        self.z_rng = z1..z2
    end

    def overlaps?(cube)
        self.x_rng.overlaps?(cube.x_rng) && self.y_rng.overlaps?(cube.y_rng) && self.z_rng.overlaps?(cube.z_rng)
    end

    def trim_cube
        Cube.new(*to_a.map {|r| r < CUBE_RANGE.first ? CUBE_RANGE.first : ( r > CUBE_RANGE.last ? CUBE_RANGE.last : r )})
    end
    
    def write_to_map(cube_map, val)
        x_rng.each do |x|
            y_rng.each do |y|
                z_rng.each do |z|
                    cube_map[x+50][y+50][z+50] = val
                end
            end
        end
    end

    def to_a
        [x_rng.first, x_rng.last, y_rng.first, y_rng.last, z_rng.first, z_rng.last]
    end
end

insts = insts.map{|line| [line[0], Cube.new(*line[1]) ] }
map = Array.new(CUBE_RANGE.size) { Array.new(CUBE_RANGE.size) { Array.new(CUBE_RANGE.size){ OFF } } }

initialization_cube = Cube.new(-50,50,-50,50,-50,50)
relevant_insts = insts.select{|i| i[1].overlaps?(initialization_cube)}
relevant_insts.each{|i| i[1].write_to_map(map, i[0])}

pp map.flatten.count(ON)
