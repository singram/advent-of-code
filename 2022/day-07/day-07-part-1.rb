#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)
input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k"

input     = input.split("\n")

SEPARATER = '/'
ROOT_DIR = '/'
current_dir  = ROOT_DIR
file_sys = {}

# Build out filesystem map 'dir+filename' -> size
input.each do |cmd|
    # pp '----------------'
    # pp cmd
    if cmd =~ /\$ cd (.*)$/i 
        dir = $1
        if dir == '..'
            # current_dir = current_dir.gsub(/\/(\w+)$/, "")
            current_dir = File.dirname(current_dir)
        elsif dir == ROOT_DIR
            current_dir = ROOT_DIR
        else
            current_dir += $1 + SEPARATER  
        end
    #   puts "CD -> #{$1}"
      
    #   current_dir = $1 == ROOT_DIR ? ROOT_DIR : current_dir += SEPARATER + $1
    elsif cmd =~ /\$ ls$/i
        next
    elsif cmd =~ /(.*) (.*)/ 
        file_sys[current_dir+$2] = $1.to_i unless $1 == 'dir'
    end
    # pp current_dir
    # pp file_sys
end

# Extract all unique paths including root
paths = file_sys.map{ |file_path,size| File.dirname(file_path) }.uniq

# Calculate total size of paths including sub directories
path_totals = {}
paths.each do |path| 
    path_totals[path] = file_sys.select{|fspath, fssize| fspath.start_with?(path)}.values.inject(&:+)
end

# Output the sum of all paths <= 100000 in size
pp path_totals.select{ |fspath, fssize| fssize <= 100000 }.values.inject(&:+)

# pp file_sys
# pp paths
 pp path_totals

