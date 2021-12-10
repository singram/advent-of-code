#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

lines = input.split("\n").map{|l| l.split('')}

char_score = {'(' => 1,
    '[' => 2,
    '{' => 3,
    '<' => 4}

incomplete_rows = []
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
            # line is corrupt
            stack = nil
            break 
        end
    end
    incomplete_rows << stack if stack
end

scores = incomplete_rows.map{ |row| row.reverse.inject(0){ |score, c| (score*5)+char_score[c] } }.sort

pp scores[scores.size/2]