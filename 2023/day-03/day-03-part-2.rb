#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

map        = input.split("\n") 

# Assumption: Numbers are distributed meaning there are no duplicates in close proximity
num_map = {}
map.each_with_index do | row, row_index |
    row.enum_for(:scan, /\d+/).map { Regexp.last_match }.each do |match|
        number =  match[0].to_i
        position = match.begin(0) 
        (0...match[0].size).each {|i| num_map[[row_index, position+i]] = number}
    end
end

# Iterate over maps looking for '*' instances and check number map for adjacent parts
sum_gear_ratio = 0
map.each_with_index do | row, row_index |
    row.enum_for(:scan, '*').map { Regexp.last_match }.each do |match|
        part_numbers = []
        ref_col = match.begin(0) 
        [-1,0,1].each do |row_offset|
            [-1,0,1].each do |col_offset|
                part_numbers << num_map[[row_index+row_offset, ref_col+col_offset]]
            end
        end
        part_numbers = part_numbers.compact.uniq
        
        sum_gear_ratio += part_numbers.inject(&:*) if part_numbers.size == 2
    end
end

pp sum_gear_ratio

