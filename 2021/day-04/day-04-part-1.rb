#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

input     = input.split("\n\n")

game_numbers = input.shift.split(',').map(&:to_i)
game_boards  = input.map{ |b| b.split("\n").map{ |line| line.split(' ').map(&:to_i) } }

def winner?(board)
    board.any?{ |h_line| h_line.compact.empty?} || board.transpose.any?{|v_line| v_line.compact.empty? }
end

def mark_number(board, number)
    board.map{ |line| line.map{ |i| i==number ? nil : i } }
end

next_number = nil
while !game_numbers.empty? && !game_boards.any?{ |board| winner?(board) }
    next_number = game_numbers.shift
    game_boards.map!{ |board| mark_number(board, next_number) }
end

winner = game_boards.find{ |board| winner?(board) }
answer = winner.flatten.compact.sum * next_number
pp answer