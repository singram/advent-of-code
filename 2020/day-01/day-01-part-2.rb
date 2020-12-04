#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

#Use of set is tempting but ignores the case where 1010 + 1010 = 2020
arr = input.split("\n").map(&:to_i)

tripple =  arr.combination(3).find{|p| p.sum == 2020}
puts tripple[0] * tripple[1] * tripple[2]
