#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

SEGMENT_COUNT = {
    0 => "abcefg",
    1 => "cf",      # Unique
    2 => "acdeg",
    3 => "acdfg",
    4 => "bcdf",    # Unique
    5 => "abdfg",
    6 => "abdefg",
    7 => "acf",     # Unique
    8 => "abcdefg", # Unique
    9 => "abcdfg"
}

problems = input.split("\n").map{|line| line.split(" | ").map{|side|side.split(" ").map{|input| input.split('').sort} } }

def decode(digit_inputs)
    decoder = {0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    decoder[1] = digit_inputs.find{|i| i.size == SEGMENT_COUNT[1].size }
    decoder[4] = digit_inputs.find{|i| i.size == SEGMENT_COUNT[4].size }
    decoder[7] = digit_inputs.find{|i| i.size == SEGMENT_COUNT[7].size }
    decoder[8] = digit_inputs.find{|i| i.size == SEGMENT_COUNT[8].size }

    # 9 includes all segments from 4 & 7 with only one remainder.
    decoder[9] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[9].size  && (decoder[7]-d).empty? &&  (d - decoder[4] - decoder[7]).size == 1 }
    # 0 includes all segments from 7 but is not 9
    decoder[0] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[0].size  && (decoder[7]-d).empty? &&  d != decoder[9] }
    # 6 is the last 6 segment number not 9 or 6
    decoder[6] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[6].size  && d != decoder[9] && d != decoder[0]}
    # 3 is the only 5 segment digit inlcuding segements from 7
    decoder[3] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[3].size  && (decoder[7]-d).empty? }
    # 5 is has 5 segments, is not 3 and contains all but 1 segment of digit 4
    decoder[5] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[5].size  && d != decoder[3] && (decoder[4]-d).size == 1 }
    decoder[2] = digit_inputs.find{ |d| d.size == SEGMENT_COUNT[5].size  && d != decoder[3] && d != decoder[5] }
    decoder.invert
end

outputs = problems.map do |input, output|
    decoder = decode(input)
    # decode digits and return an int
    output.map{|digit| decoder[digit].to_s}.join.to_i
end

pp outputs.sum
