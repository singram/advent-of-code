#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

constraints = { red: 12, green: 13, blue: 14}

games = {}
input.split("\n") do |line|
    (game, sets) = line.split(':')
    game = game.scan(/\d+/)[0].to_i
    games[game] = []
    sets.split(";").each do |set|
        h = {}
        set.split(',').each do |combo|
            (num, col) = combo.strip.split(' ')
            h[col.to_sym] = num.to_i
        end
        games[game] << h
    end
end

pp games.select{|games, sets| sets.all?{|set| set.all?{|col,num| constraints[col] >= num } } }.keys.sum
