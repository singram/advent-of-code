#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('day-22-input.txt', __dir__)
input     = File.read(file_path)

OFF = 0
ON  = 1

instructions = input.split("\n").map { |line| line.split(' ') }
instructions = instructions.map do |line|
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

  def initialize(x1_x2, y1_y2, z1_z2)
    self.x_rng = x1_x2
    self.y_rng = y1_y2
    self.z_rng = z1_z2
  end

  # Does the cube overlap in any way
  def overlaps?(cube)
    x_rng.overlaps?(cube.x_rng) && y_rng.overlaps?(cube.y_rng) && z_rng.overlaps?(cube.z_rng)
  end

  def volume
    [x_rng, y_rng, z_rng].map(&:size).inject(:*)
  end

  def to_a
    [x_rng, y_rng, z_rng].map(&:to_a).flatten
  end

  def subtract(cube)
    # If cube does not overlap then theres nothing to subtract
    return self unless overlaps?(cube)

    x_ranges, y_ranges, z_ranges = %i[x_rng y_rng z_rng].map { |rng| spans(cube, rng) }
    remaining_cubes = []
    x_ranges.each do |x_range, x_cubes|
      y_ranges.each do |y_range, y_cubes|
        z_ranges.each do |z_range, z_cubes|
          # Only create cubes that exclusively belong to the original cube (self) and not the cube being subtracted
          remaining_cubes << Cube.new(x_range, y_range, z_range) if (x_cubes & y_cubes & z_cubes) == [self]
        end
      end
    end
    remaining_cubes
  end

  private

  FIRST = 0
  LAST = 1
  def spans(cube, range_sym)
    points = []
    points << [send(range_sym).first, FIRST, self]
    points << [send(range_sym).last,  LAST, self]
    points << [cube.send(range_sym).first, FIRST, cube]
    points << [cube.send(range_sym).last, LAST, cube]
    points.sort! { |p1, p2| p1[0] + p1[1] <=> p2[0] + p2[1] }

    start = 0
    stack = []
    span_list = []
    points.each do |point, edge, c|
      if edge == FIRST
        if start.nil? || start == point
          start = point
          stack += [c]
        else
          span_list << [start..point - 1, stack.dup]
          start = point
          stack += [c]
        end
      elsif edge == LAST
        if point >= start
          span_list << [start..point, stack.dup]
          stack -= [c]
          start = point + 1
        else
          stack -= [c]
        end
      end
    end
    # Span list is an array containing [ [range,[cubes in range], ... ] ]
    span_list
  end
end

ONOFF = 0
CUBE = 1
instructions = instructions.map do |line|
  [line[0], Cube.new(line[1][0]..line[1][1], line[1][2]..line[1][3], line[1][4]..line[1][5])]
end

# Assign first cubic instruction to the reactor (assiming it's an ON which the test set is)
# Reactor is an array of ON cubes only.
reactor = [instructions.shift[CUBE]]

instructions.each do |instruction|
  # Subtract new cube from existing reactor ON cubes
  reactor = reactor.flat_map { |reactor_cube| reactor_cube.subtract(instruction[CUBE]) }
  # Add new cube if instruction is set to ON
  reactor << instruction[CUBE] if instruction[ONOFF] == ON
end

# Sum volumes of all ON cubes (the only cubes in the reactor array)
pp reactor.map(&:volume).sum

# 1019187529428416 < TOO LOW
