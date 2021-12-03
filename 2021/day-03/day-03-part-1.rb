#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

require 'matrix'
input = input.split("\n").map{|s| s.split('').map(&:to_i)}

diag_size = input.size
counter = nil
input.each do |bits|
    counter ||= Vector[*Array.new(bits.size, 0)]
    counter += Vector[*bits]
end

gamma = counter.to_a.map{|bit| bit > diag_size/2 ? '1' : '0'}.join.to_i(2)
epsilon = counter.to_a.map{|bit| bit < diag_size/2 ? '1' : '0'}.join.to_i(2)
pp gamma * epsilon

