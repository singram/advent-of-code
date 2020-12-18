#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

code_seq = input.split("\n").map(&:to_i)

PRE_AMBLE=25
code_seq.each_cons(PRE_AMBLE+1).select do |codes|
  code = codes.pop
  p code unless codes.combination(2).map(&:sum).any?{|s| s==code}
end
