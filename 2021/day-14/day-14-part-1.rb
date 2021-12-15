#!/usr/bin/env ruby

file_path = File.expand_path("../day-14-input.txt", __FILE__)
input     = File.read(file_path)

template, rules_raw = input.split("\n\n")

template = template.split('')
rules  = {}
rules_raw.split("\n").each{ |line| parts = line.split(' -> '); rules[parts[0].split('')] = parts[1] }

10.times do 
    new_template = []
    template.each_cons(2) do |pair|
        new_template << pair[0]
        new_template << rules[pair] if rules[pair]
    end
    new_template << template.last
    template = new_template
end

counts = {}
template.each do |t|
    counts[t] ||= 0
    counts[t] += 1
end

pp counts.values.max - counts.values.min