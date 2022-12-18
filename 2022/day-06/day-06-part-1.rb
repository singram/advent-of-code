#!/usr/bin/env ruby

file_path = File.expand_path("../day-06-input.txt", __FILE__)
input     = File.read(file_path)

MKR_SIZE = 4

input = input.split('')

idx = (0..input.size-1).find do |idx|
    input.slice(idx, MKR_SIZE).uniq.size == MKR_SIZE
end

pp idx + MKR_SIZE