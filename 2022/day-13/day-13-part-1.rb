#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

# input = "[1,1,3,1,1]
# [1,1,5,1,1]

# [[1],[2,3,4]]
# [[1],4]

# [9]
# [[8,7,6]]

# [[4,4],4,4]
# [[4,4],4,4,4]

# [7,7,7,7]
# [7,7,7]

# []
# [3]

# [[[]]]
# [[]]

# [1,[2,[3,[4,[5,6,7]]]],8,9]
# [1,[2,[3,[4,[5,6,0]]]],8,9]"

pairs={}
input.split("\n\n").each_with_index{|p, idx| pairs[idx+1] = p.split("\n").map{|s| eval(s) }}

def is_array_valid?(l, r)
    l = [l] if l.is_a? Integer
    r = [l] if r.is_a? Integer
    return true if l.empty? #&& !r.empty?
    return false if r.empty? #&& !r.empty?
    l.each_with_index do |l_element, idx|
        return false if r[idx].nil?
        if r[idx].is_a?(Integer) && l_element.is_a?(Integer)
            return false if l_element > r[idx]
            return true  if l_element < r[idx]
        else
            evaluation = is_array_valid?(l_element, r[idx])
            return evaluation unless evaluation.nil?
        end
    end
    # If left has been exhausted with members remaining in right then it's in the correct order
    # otherwise return nil to continue.
    l.size < r.size ? true : nil
end

pairs.each do |pair, lr|
    pp "#{pair} -> #{is_array_valid?(*lr)}"
    pp lr[0]
    pp lr[1]
    pp '-----------------------------'
end

#6861 is too high

pp pairs.transform_values {|lr| is_array_valid?(*lr) }.select{|k,v| v==true}.keys.sum