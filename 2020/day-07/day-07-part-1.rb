#!/usr/bin/env ruby

file_path = File.expand_path("../day-07-input.txt", __FILE__)
input     = File.read(file_path)

# e.g vibrant yellow bags contain 5 dark salmon bags, 5 dull green bags, 3 light silver bags.

RULES = {}
input.split("\n").map{|line| line.gsub("\.",'').gsub(/\sbags?/,'').split(' contain ')}.each do |bag, contains|
  RULES[bag] = {}
  contains.split(', ').map{|rule| rule.split(' ',2)}.each{|rule_count, contained_bag| RULES[bag][contained_bag]=rule_count.to_i}
end

def can_contain?(bag, tgt)
  return true if RULES[bag][tgt] && RULES[bag][tgt]> 0
  remaining = RULES[bag].select{|b,cnt| cnt > 0 }.keys
  return false if remaining.empty?
  remaining.any?{|next_bag| can_contain?(next_bag, tgt)}
end

p RULES.keys.select{|bag| can_contain?(bag, 'shiny gold')}.count
