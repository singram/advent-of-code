#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split.map(&:to_i)

input = input.each_cons(3).map(&:sum)

pp input.each_cons(2).map{ |depth_n, depth_n1| depth_n1 > depth_n ? 1 : 0 }.sum
