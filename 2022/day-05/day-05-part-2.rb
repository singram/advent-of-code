#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

stacks, instructions = input.split("\n\n")

instructions = instructions.split("\n").map{ |l| l.scan(/\d+/).map(&:to_i) }
SIZE = 0
FROM = 1
TO   = 2

stacks = {
    1 => "DLVTMHF",
    2 => "HQGJCTNP",
    3 => "RSDMPH",
    4 => "LBVF",
    5 => "NHGLQ",
    6 => "WBDGRMP",
    7 => "GMNRCHLQ",
    8 => "CLW",
    9 => "RDLQJZMT"
}

instructions.each do |i|
    stacks[i[TO]] += stacks[i[FROM]].slice!(-1*i[SIZE], i[SIZE])
end
pp stacks.values.map{|s| s[-1]}.join
