#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

sacks = input.split("\n")

items_to_rearrange = sacks.map do |sack|
    items = sack.split('')
    comp1, comp2 = items.each_slice( (items.size/2.0).round ).to_a
    (comp1.uniq & comp2.uniq)
end.flatten

# Lowercase item types a through z have priorities 1 through 26.
# Uppercase item types A through Z have priorities 27 through 52.
priorities = items_to_rearrange.map do |i|
    ("a".."z").include?(i) ? i.ord - 96 :  i.ord - 38
end
pp priorities.sum