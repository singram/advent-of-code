#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

CLOCK_COST = {
    'noop' => 1,
    'addx' => 2
}

costs = {}

x = 1
clock = 0
next_trigger = 20
TRIGGER_FREQ = 40
TRIGGER_MAX = 221

input.split("\n").map{ |l| l.split(' ') }.each do |inst, val|
    if clock+CLOCK_COST[inst] >= next_trigger
        costs[next_trigger] = x
        next_trigger += TRIGGER_FREQ
    end
    clock += CLOCK_COST[inst]
    x += val.to_i if inst == 'addx'
    break if TRIGGER_MAX < clock
end

# pp costs
pp costs.keys.map{|k| k * costs[k]}.sum

