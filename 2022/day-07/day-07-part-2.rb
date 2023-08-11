#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

input     = input.split("\n")

require 'pathname'

current_dir  = Pathname.new('/')
file_sys = {}
dirs = { current_dir => true}

# Build out filesystem map 'dir+filename' -> size
input.each do |cmd|
    if cmd =~ /\$ cd (.*)$/i 
        current_dir = $1 == '/' ? Pathname.new('/') : current_dir + $1
    elsif cmd =~ /dir (.*)/ 
        # Assumption: All dirs are explicitly mentioned in input file.
        dirs[current_dir+$1] = true
    elsif cmd =~ /(\d+) (.*)/ 
        file_sys[current_dir+$2] = $1.to_i 
    end
end

dir_totals = {}
dirs.each do |dir, x|
    dir_totals[dir] = file_sys.select{|fspath, fssize| fspath.to_s.start_with?(dir.to_s)}.values.sum
end

space_needed = 30000000 - (70000000 - dir_totals[Pathname.new('/')])
pp dir_totals.values.sort.find{|a| a >= space_needed}

