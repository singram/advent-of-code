#!/usr/bin/env ruby

file_path = File.expand_path("../day-03-input.txt", __FILE__)
input     = File.read(file_path)

require 'matrix'
input = input.split("\n").map{|s| s.split('').map(&:to_i)}

def filter_numbers(list, most_common, bit_pos = 0)
    bit_count = list.map{ |bits| bits[bit_pos] }.sum
    mid_point = list.size/2.0
    # Find common bit value
    common_bit = (bit_count > mid_point) ? 1 : 0
    # Flip if the least common is needed
    common_bit = common_bit == 1 ? 0 : 1 unless most_common
    # Resolve if equal
    common_bit = most_common ? 1 : 0 if bit_count == mid_point
    # Filter list by bit
    new_list = list.select{ |bits| bits[bit_pos] == common_bit }
    # Reduce until there is only one
    new_list.size == 1 ? new_list[0] : filter_numbers(new_list, most_common, bit_pos+=1)
end

def bin_arr_to_i(a)
    a.map(&:to_s).join.to_i(2)
end

oxygen_generator_rating = bin_arr_to_i(filter_numbers(input.dup, true))
co2_scrubber_rating     = bin_arr_to_i(filter_numbers(input.dup, false))
pp oxygen_generator_rating * co2_scrubber_rating

