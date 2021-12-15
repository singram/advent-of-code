#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

template, rules_raw = input.split("\n\n")

template = template.split('')
rules  = {}
rules_raw.split("\n").each{ |line| parts = line.split(' -> '); rules[parts[0].split('')] = parts[1] }

# Initialize pair counts from initial template
pairs = {}
template.each_cons(2) do |pair|
    pairs[pair] ||=0
    pairs[pair] += 1
end

# Map existing pairs to the new pairs preserving counts.
40.times do |i|
    new_pairs= {}
    pairs.keys.each do |pair|
        if rules[pair]
            ins = rules[pair]
            [ [pair[0],ins], [ins,pair[1]] ].each do |new_pair| 
                new_pairs[new_pair] ||= 0
                new_pairs[new_pair] += pairs[pair]
            end
        else
            new_pairs[pair] = pairs[pair]
        end
    end
    pairs = new_pairs
end

# Don't forget the start & end chars which never change and do not mutate in the above algorithm
counts = {template.first => 1, template.last => 1}
pairs.each do |pair, val|
    pair.each do |char|
        counts[char] ||= 0
        counts[char] += val
    end
end

pp (counts.values.max - counts.values.min)/2