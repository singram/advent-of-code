#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n").map{|l| l.split('')}

char_scores = {')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137}

corrupt_chars = []
lines.each do |line|
    stack = []
    line.each do |ch|
        if ['(','[','{','<'].include?(ch)
            stack.push ch
        else
            op_char = stack.pop
            next if op_char == '(' && ch == ')'
            next if op_char == '[' && ch == ']'
            next if op_char == '{' && ch == '}'
            next if op_char == '<' && ch == '>'
            corrupt_chars << ch
            break # line is corrupt
        end
    end
end

pp corrupt_chars.map{|c| char_scores[c]}.sum
