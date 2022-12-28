#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

CLOCK_COST = {
    'noop' => 1,
    'addx' => 2
}

SCREEN_WIDTH = 40

def sprite_rng(x)
    (x-1..x+1)
end

def print_pixel(clock, x)
    print sprite_rng(x).include?((clock-1) % SCREEN_WIDTH) ? '#' : '.'
    print "\n" if clock % SCREEN_WIDTH == 0
end

clock = 0
x = 1

input.split("\n").map{ |l| l.split(' ') }.each do |inst, val|
    if CLOCK_COST[inst] > 1
        clock +=1
        print_pixel(clock, x)
    end
    clock += 1
    print_pixel(clock, x)
    x += val.to_i if inst == 'addx'
end

