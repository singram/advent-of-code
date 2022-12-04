#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n").map{ |line| line.split(/[-,]/).map(&:to_i) }.map{ |a| [(a[0]..a[1]), (a[2]..a[3])] }

pp input.select { |p1,p2| 
    p1.include?(p2.first) || 
    p1.include?(p2.last)  || 
    p2.include?(p1.first) || 
    p2.include?(p1.last)}.count
