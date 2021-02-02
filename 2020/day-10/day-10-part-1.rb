#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

adapters = [0] + input.split("\n").map(&:to_i)
adapters.sort!

# Initialized accomodating 3 jolt different with end device.
diff = {0=>0, 1=>0, 2=>0, 3=>1}
(0...adapters.size-1).each do |i|
  diff[adapters[i+1]-adapters[i]] += 1
end
p diff[1] * diff[3]
