#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

SYMBOL_PROXIMITY = '*'
EMPTY = '.'
map        = input.split("\n").map{|l| l.split('')}

# Create proximity map for symbols in map
ROWS = map.size
COLS = map[0].size
symbol_map = Array.new(ROWS) { Array.new(COLS, EMPTY) }
map.each_with_index do | row, row_index |
    row.each_with_index do | element, col_index|
        next if element.match?(/[0-9\.]/) # Ignore if the element is a number or empty position.
        [-1,0,1].each do |row_offset|
            [-1,0,1].each do |col_offset|
                tgt_row = row_index + row_offset
                tgt_col = col_index + col_offset
                if tgt_col.between?(0,COLS-1) && tgt_row.between?(0,ROWS-1)
                    symbol_map[tgt_row][tgt_col] = SYMBOL_PROXIMITY
                end
            end
        end
    end
end

map        = map.map(&:join)
symbol_map = symbol_map.map(&:join)

num_sum = 0
map.each do |row|
    mask = symbol_map.shift
    row.enum_for(:scan, /\d+/).map { Regexp.last_match }.each do |match|
        number =  match[0].to_i
        position = match.begin(0) 
        mask_match = mask[position, match[0].size]
        num_sum += number if mask_match.include?('*')
    end
end

pp num_sum
