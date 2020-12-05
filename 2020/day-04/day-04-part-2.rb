#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

MANDATORY_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

passports =  input.split("\n\n").map{|p| p.gsub(/\s+/m, ' ').strip.split(" ")}

def valid?(kv_arr)
  fields = kv_arr.map(&:first)
  (MANDATORY_FIELDS-fields).empty? && kv_arr.all?{|k,v| send(:"#{k}_valid?", v)}
end

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
def byr_valid?(v)
  v =~ /^\d{4}$/ &&  v.to_i.between?(1920, 2002)
end

# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
def iyr_valid?(v)
  v =~ /^\d{4}$/ &&  v.to_i.between?(2010, 2020)
end

# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
def eyr_valid?(v)
  v =~ /^\d{4}$/ &&  v.to_i.between?(2020, 2030)
end

# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
def hgt_valid?(v)
  h, unit = v.match(/^(\d+)(\w+)$/i).captures
  (unit == 'cm' && h.to_i.between?(150,193)) || (unit == 'in' && h.to_i.between?(59,76))
end

# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
def hcl_valid?(v)
  v =~ /^#[0-9a-f]{6}$/
end

# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
def ecl_valid?(v)
  ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(v)
end

# pid (Passport ID) - a nine-digit number, including leading zeroes.
def pid_valid?(v)
  v =~ /^\d{9}$/
end

# cid (Country ID) - ignored, missing or not.
def cid_valid?(v)
  true
end


valid_passports = passports.select do |p|
  valid?(p.map{|kv| kv.split(':')})
end

puts valid_passports.count
