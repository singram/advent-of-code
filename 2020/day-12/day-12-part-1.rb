#!/usr/bin/env ruby
require 'matrix'
file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

instructions = input.split("\n")

VEC = {
  'E': Vector[1,0],
  'S': Vector[0,-1],
  'W': Vector[-1,0],
  'N': Vector[0,1]
}

TRANSFORM = {
  'E': {'R90':'S', 'R180':'W', 'R270':'N', 'L90':'N', 'L180':'W', 'L270':'S'},
  'S': {'R90':'W', 'R180':'N', 'R270':'E', 'L90':'E', 'L180':'N', 'L270':'W'},
  'W': {'R90':'N', 'R180':'E', 'R270':'S', 'L90':'S', 'L180':'E', 'L270':'N'},
  'N': {'R90':'E', 'R180':'S', 'R270':'W', 'L90':'W', 'L180':'S', 'L270':'E'}
}

STATE = { location: Vector[0,0], dir: 'E'.to_sym }

instructions.each do |instruction|
  # pp instruction, STATE
  (inst, val) = instruction.match(/(\w)(\d+)/).captures
  # Action N means to move north by the given value.
  # Action S means to move south by the given value.
  # Action E means to move east by the given value.
  # Action W means to move west by the given value.
  # Action L means to turn left the given number of degrees.
  # Action R means to turn right the given number of degrees.
  # Action F means to move forward by the given value in the direction the ship is currently facing.
  if ['N','S','E','W'].include?(inst)
    v = VEC[inst.to_sym] * val.to_i
    STATE[:location] += v
  elsif ['L','R'].include?(inst)
    STATE[:dir] = TRANSFORM[STATE[:dir]][instruction.to_sym].to_sym
  elsif inst == 'F'
    STATE[:location] += VEC[STATE[:dir]] * val.to_i
  end
end

pp STATE[:location].map(&:abs).sum
