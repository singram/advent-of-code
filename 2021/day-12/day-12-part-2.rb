#!/usr/bin/env ruby

file_path = File.expand_path("../day-12-input.txt", __FILE__)
input     = File.read(file_path)

connections = {}

input = input.split("\n").map{ |line| line.split('-')}
input.each do |option| 
    connections[option[0]] ||= []; connections[option[0]] += [option[1]] unless option[1] == 'start'
    connections[option[1]] ||= []; connections[option[1]] += [option[0]] unless option[0] == 'start'
end
connections.delete('end')

def find_paths(path, connections)
    next_options = []
    next_options = connections[path.last] unless path.last == 'end'  # Don't reverse course from end destination
    # Detect a small cave visited twice
    small_cave_revisited = path.select{|cave| cave.downcase == cave}.detect{ |small_cave| path.count(small_cave) > 1 }
    # Reject all lower case destinations already visited if a small cave has been visited twice already
    next_options = next_options.reject{|option| option.downcase == option && path.include?(option)} if small_cave_revisited
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



