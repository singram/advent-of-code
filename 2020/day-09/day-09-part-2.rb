#!/usr/bin/env ruby

file_path = File.expand_path("../day-09-input.txt", __FILE__)
input     = File.read(file_path)

code_seq = input.split("\n").map(&:to_i)

TARGET = 88311122

(0...code_seq.size).each do |start_i|
  acc = 0
  end_i = start_i
  while acc < TARGET
    acc += code_seq[end_i]
    end_i += 1
  end
  if acc == TARGET
    # Note that 2 answers are generated, the first is the one expected by AoC
    p code_seq[start_i..end_i].min + code_seq[start_i..end_i].max
  end
end
