#!/usr/bin/env ruby

file_path = File.expand_path("../day-04-input.txt", __FILE__)
input     = File.read(file_path)

results = input.split("\n").map do |line|
    (game, number_line) = line.split(':')
    game = game.scan(/\d+/)[0].to_i
    (card_str, winners_str) = number_line.split('|')
    card    = card_str.split(' ').map(&:to_i)
    winners = winners_str.split(' ').map(&:to_i)
    matches = card & winners
    matches.size == 0 ? 0 : 2**(matches.size-1)
end

pp results.sum


