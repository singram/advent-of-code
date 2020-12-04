#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

#Use of set is tempting but ignores the case where 1010 + 1010 = 2020
arr = input.split("\n").map(&:to_i)

pair =  arr.combination(2).find{|p| p[0]+p[1]==2020}
puts pair[0] * pair[1]
