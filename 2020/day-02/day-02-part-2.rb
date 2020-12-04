#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

valid = input.split("\n").select do |i|
  pos1, pos2, ch, pwd = i.match(/(\d+)-(\d+)\s(\w):\s(\w+)/i).captures
  ( pwd[pos1.to_i-1] == ch ) ^ ( pwd[pos2.to_i-1] == ch )
end

puts valid.count
