#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split("\n").map{ |line| line.split(/[-,]/).map(&:to_i) }.map{ |a| [(a[0]..a[1]), (a[2]..a[3])] }

class Range
    def fully_include?(r)
        (r.first >= self.first && r.last <= self.last)
    end
end

pp input.select{|p1,p2| p1.fully_include?(p2) || p2.fully_include?(p1) }.count