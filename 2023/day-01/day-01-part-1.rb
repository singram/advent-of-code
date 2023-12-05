#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n")
result = input.map do |line|
    (line[/\d{1}/] + line[/\d{1}\D*$/][0]).to_i
end.sum
pp result
