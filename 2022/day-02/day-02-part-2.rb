#!/usr/bin/env ruby

file_path = File.expand_path("../day-02-input.txt", __FILE__)
input     = File.read(file_path)

# A for Rock, B for Paper, and C for Scissors.
# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
# 1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the 
# outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
score = {
    # => outcome + play
    "A X" => 0+3,
    "A Y" => 3+1,
    "A Z" => 6+2,
    "B X" => 0+1,
    "B Y" => 3+2,
    "B Z" => 6+3,
    "C X" => 0+2,
    "C Y" => 3+3,
    "C Z" => 6+1
}

scores = input.split("\n").map{ |play| score[play] }
pp scores.sum