#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

groups =  input.split("\n\n")

puts groups.map{|grp| grp.gsub("\n",'').split('').uniq.count}.sum
