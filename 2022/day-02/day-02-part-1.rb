#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

# A for Rock, B for Paper, and C for Scissors.
# X for Rock, Y for Paper, and Z for Scissors
# 1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the 
# outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
score = {
     # => play + outcome
    "A X" => 1+3,
    "A Y" => 2+6,
    "A Z" => 3+0,
    "B X" => 1+0,
    "B Y" => 2+3,
    "B Z" => 3+6,
    "C X" => 1+6,
    "C Y" => 2+0,
    "C Z" => 3+3
}

scores = input.split("\n").map{ |play| score[play] }
pp scores.sum