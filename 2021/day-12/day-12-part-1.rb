#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

connections = {}

input = input.split("\n").map{ |line| line.split('-')}
input.each do |option| 
    connections[option[0]] ||= []; connections[option[0]] += [option[1]]
    connections[option[1]] ||= []; connections[option[1]] += [option[0]]
end

def find_paths(path, connections)
    next_options = []
    next_options = connections[path.last] unless path.last == 'end'  # Don't reverse course from end destination
    # Reject all lower case destinations already visited
    next_options = next_options.reject{|option| option.downcase == option && path.include?(option)}
    paths = []
    if next_options.empty?
        paths << path if path.last == 'end'
    else
        next_options.each do |option| 
            paths += find_paths(path+[option], connections)
        end
    end
    paths
end

 pp find_paths(['start'], connections).count
#  pp connections



