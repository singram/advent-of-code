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

# Functions to rotate the waypoint vector
def R90(v)  Vector[v[1], v[0]*-1] end
def R180(v) R90(R90(v)) end
def R270(v) R90(R90(R90(v))) end
def L90(v)  R270(v) end
def L180(v) R180(v) end
def L270(v) R90(v) end

# Vector[East, North]
STATE = { location: Vector[0,0], waypoint: Vector[10, 1] }

instructions.each do |instruction|
  # pp instruction, STATE
  (inst, val) = instruction.match(/(\w)(\d+)/).captures
  # Action N means to move the waypoint north by the given value.
  # Action S means to move the waypoint south by the given value.
  # Action E means to move the waypoint east by the given value.
  # Action W means to move the waypoint west by the given value.
  # Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
  # Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
  # Action F means to move forward to the waypoint a number of times equal to the given value.
  # The waypoint starts 10 units east and 1 unit north relative to the ship. The waypoint is relative to the ship; that is, if the ship moves, the waypoint moves with it.
  if ['N','S','E','W'].include?(inst)
    v = VEC[inst.to_sym] * val.to_i
    STATE[:waypoint] += v
  elsif ['L','R'].include?(inst)
    STATE[:waypoint] = send(instruction.to_sym, STATE[:waypoint])
  elsif inst == 'F'
    STATE[:location] += STATE[:waypoint] * val.to_i
  end
end

pp STATE[:location].map(&:abs).sum
