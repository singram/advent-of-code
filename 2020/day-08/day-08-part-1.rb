#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

inst = input.split("\n").map{|line| line.split(' ')}.map{|op, n| [op, n.to_i]}

i = 0
acc = 0

while !inst[i].nil?
  op, n = inst[i]
  inst[i] = nil
  acc += n if op == 'acc'
  n = 1 if op == 'nop' || op == 'acc'
  i += n 
end

pp acc
