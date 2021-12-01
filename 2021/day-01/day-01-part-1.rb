#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split.map(&:to_i)

inc_count = 0
input.each_cons(2) do |depth_n, depth_n1|
    inc_count += 1 if depth_n1 > depth_n
end
pp inc_count