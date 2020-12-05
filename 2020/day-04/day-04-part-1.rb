#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

MANDATORY_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

passports =  input.split("\n\n").map{|p| p.gsub(/\s+/m, ' ').strip.split(" ")}

def valid?(kv_arr)
  fields = kv_arr.map(&:first)
  (MANDATORY_FIELDS-fields).empty?
end

valid_passports = passports.select do |p|
  valid?(p.map{|kv| kv.split(':')})
end

puts valid_passports.count
