#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('day-22-input.txt', __dir__)
input     = File.read(file_path)

OFF = 0
ON  = 1
CUBE_RANGE = (-50..50).freeze

insts = input.split("\n").map { |line| line.split(' ') }
insts = insts.map do |line|
  [line[0] == 'on' ? ON : OFF,
   line[1].match(/x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/).captures.map(&:to_i)]
end

# Monkey patching Range class
class Range
  # Returns true if the range supplied overlaps the current range.
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end
end

# Representation of a cube in 3d space
class Cube
  attr_accessor :x_rng, :y_rng, :z_rng

  def initialize(x1, x2, y1, y2, z1, z2)
    self.x_rng = x1..x2
    self.y_rng = y1..y2
    self.z_rng = z1..z2
  end

  def overlaps?(cube)
    x_rng.overlaps?(cube.x_rng) && y_rng.overlaps?(cube.y_rng) && z_rng.overlaps?(cube.z_rng)
  end

  def trim_cube
    Cube.new(*to_a.map do |r|
               if r < CUBE_RANGE.first
                 CUBE_RANGE.first
               else
                 (r > CUBE_RANGE.last ? CUBE_RANGE.last : r)
               end
             end)
  end

  def write_to_map(cube_map, val)
    x_rng.each do |x|
      y_rng.each do |y|
        z_rng.each do |z|
          cube_map[x + 50][y + 50][z + 50] = val
        end
      end
    end
  end

  def to_a
    [x_rng.first, x_rng.last, y_rng.first, y_rng.last, z_rng.first, z_rng.last]
  end
end

insts = insts.map { |line| [line[0], Cube.new(*line[1])] }
map   = Array.new(CUBE_RANGE.size) { Array.new(CUBE_RANGE.size) { Array.new(CUBE_RANGE.size) { OFF } } }

initialization_cube = Cube.new(-50, 50, -50, 50, -50, 50)
relevant_insts      = insts.select { |i| i[1].overlaps?(initialization_cube) }
relevant_insts.each { |i| i[1].write_to_map(map, i[0]) }

pp map.flatten.count(ON)
