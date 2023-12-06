#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

games = {}
input.split("\n") do |line|
    (game, sets) = line.split(':')
    game = game.scan(/\d+/)[0].to_i
    games[game] = {}
    sets.split(";").each do |set|
        set.split(',').each do |combo|
            (num, color) = combo.strip.split(' ')
            color = color.to_sym
            num = num.to_i
            games[game][color] ||= num
            games[game][color] = num if num > games[game][color]
        end
    end
    games[game] = games[game].values.inject(:*)
end

pp games.values.sum
