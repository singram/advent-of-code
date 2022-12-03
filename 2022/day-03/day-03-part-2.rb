#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

sacks = input.split("\n")
badges = sacks.each_slice(3).map do |group|
    group = group.map{ |g| g.split('') }
    ( group[0].uniq & group[1].uniq & group[2].uniq )
end.flatten

# Lowercase item types a through z have priorities 1 through 26.
# Uppercase item types A through Z have priorities 27 through 52.
priorities = badges.map do |i|
    ("a".."z").include?(i) ? i.ord - 96 :  i.ord - 38
end
pp priorities.sum