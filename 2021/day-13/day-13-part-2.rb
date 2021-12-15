#!/usr/bin/env ruby

file_path = File.expand_path("../day-13-input.txt", __FILE__)
input     = File.read(file_path)

coords, folds = input.split("\n\n")

coords = coords.split("\n").map{ |line| line.split(',').map(&:to_i) }
folds  = folds.split("\n").map{ |line| parts = line.split('='); [parts[0][-1],parts[1].to_i] }

def fold_map(coords, fold)
    fold_dir, fold_loc = fold
    coords.map do |coord|
        if fold_dir == 'x'
            coord[0] = fold_loc + (fold_loc - coord[0] ) if coord[0] > fold_loc
        else
            coord[1] = fold_loc + (fold_loc - coord[1] ) if coord[1] > fold_loc
        end
        coord
    end
end

folds.each do |fold|
  coords = fold_map(coords, fold).uniq
end

max_x = coords.map{ |coord| coord[0] }.max + 1
max_y = coords.map{ |coord| coord[1] }.max + 1

code = Array.new(max_y){ Array.new(max_x, ' ') }
coords.each { |coord| code[coord[1]][coord[0]] = '#' }

code.each{ |line| p line.join }

