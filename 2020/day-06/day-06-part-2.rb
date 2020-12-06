#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

groups =  input.split("\n\n")

# Split each group into people, split each persons responses into an array of responses.  Logically and the responses together and count the result for a group.  Sum all the group counts together.
puts groups.map{|grp| grp.split("\n").map{|person| person.split('')}.inject(:&).count}.sum
