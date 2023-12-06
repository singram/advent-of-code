#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

card_count = 0
copy_stack = []
results = input.split("\n").each do |line|
    (game, number_line) = line.split(':')
    game = game.scan(/\d+/)[0].to_i
    (card_str, winners_str) = number_line.split('|')
    card    = card_str.split(' ').map(&:to_i)
    winners = winners_str.split(' ').map(&:to_i)
    matches = (card & winners).size
    total_wins = 1 + (copy_stack.shift || 0)
    card_count += total_wins
    (0...matches).to_a.each{|i| copy_stack[i] = (copy_stack[i] || 0) + total_wins }
end

pp card_count


