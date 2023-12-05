#!/usr/bin/env ruby

file_path = File.expand_path("../day-01-input.txt", __FILE__)
input     = File.read(file_path)

word_digits = {
    "zero": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
}

input = input.split("\n")

result = input.map do |line|
    numbers = ""
    while line.length > 0
        if ["0","1","2","3","4","5","6","7","8","9"].include?(line[0])
            numbers += line[0] 
        else
            word_digits.keys.each do |digit|
                if line.start_with?(digit.to_s)
                    numbers += word_digits[digit] 
                    break
                end    
            end
        end
        line = line[1..-1]
    end
    (numbers[0] + numbers[-1]).to_i
end
pp result.sum