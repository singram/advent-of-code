#!/usr/bin/env ruby

file_path = File.expand_path("../day-08-input.txt", __FILE__)
input     = File.read(file_path)

INST = input.split("\n").map{|line| line.split(' ')}.map{|op, n| [op, n.to_i]}.freeze


def run_instructions(inst)
  i = 0
  acc = 0
  success = false
  while !inst[i].nil?
    op, n = inst[i]
    inst[i] = nil
    acc += n if op == 'acc'
    n = 1 if op == 'nop' || op == 'acc'
    i += n
  end
  return acc, i==inst.size
end

(0...INST.size).each do |i|
  # Deep copy original INST set as processing is destructive
  # Could be re-written to be far cheaper by tracking instruction flips and modifying the run func to be non-mutative.
  set = Marshal.load(Marshal.dump(INST))#INST.slice()
  original = set[i][0]
  if set[i][0] == 'nop'
    set[i][0] = 'jmp'
  elsif set[i][0] == 'jmp'
    set[i][0] = 'nop'
  else
    next
  end
  acc, finished = run_instructions(set)
  if finished
    p acc
    break
  end
end
