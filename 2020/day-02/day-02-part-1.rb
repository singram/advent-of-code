#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

valid = input.split("\n").select do |i|
  c_min, c_max, ch, pwd = i.match(/(\d+)-(\d+)\s(\w):\s(\w+)/i).captures
  ch_count = pwd.count(ch)
  ch_count >= c_min.to_i && ch_count <= c_max.to_i
end

puts valid.count
