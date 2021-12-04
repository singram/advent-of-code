#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

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

last_winning_game = nil
last_winning_number = nil
game_numbers.each do |game_number|
    game_boards.map!{ |board| mark_number(board, game_number) }
    winners = game_boards.select{ |board| winner?(board) }
    unless winners.empty?
        last_winning_game   = winners.first
        last_winning_number = game_number
        game_boards -= winners
    end
end

answer = last_winning_game.flatten.compact.sum * last_winning_number
pp answer
