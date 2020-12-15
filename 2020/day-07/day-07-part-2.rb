#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

# e.g vibrant yellow bags contain 5 dark salmon bags, 5 dull green bags, 3 light silver bags.

RULES = {}
input.split("\n").map{|line| line.gsub("\.",'').gsub(/\sbags?/,'').split(' contain ')}.each do |bag, contains|
  RULES[bag] = {}
  contains.split(', ').map{|rule| rule.split(' ',2)}.each{|rule_count, contained_bag| RULES[bag][contained_bag]=rule_count.to_i}
end

def count_bags(bag)
  return 1 + (RULES[bag] ? RULES[bag].map{|contained_bag, cnt| count_bags(contained_bag) * cnt}.sum : 0)
end

# Note the minux 1 to remove the original bag from the count.
pp count_bags('shiny gold') - 1
