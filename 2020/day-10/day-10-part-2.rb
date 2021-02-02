#!/usr/bin/env ruby

file_path = File.expand_path("../day-10-input.txt", __FILE__)
input     = File.read(file_path)

adapters = input.split("\n").map(&:to_i)
adapters.sort!

OUTLET_JOLT = 0
DEVICE_JOLT = adapters[-1] + 3
adapters = [OUTLET_JOLT] + adapters + [DEVICE_JOLT]

# Sequence test condition predicate 
def seq_valid?(s)
  s.each_cons(2).all?{|a,b| b-a <= 3}
end

def count_subseqs(seq)
  # A sequence of 2 cannod be smaller
  return [seq] if seq.size < 3
  result = [seq]
  # Preserve start and end sequence goals
  first = seq[0]
  last  = seq[-1]
  # Find set of solutions with one less adapter between sequence goals.
  valid_subseqs = seq[1..-2].combination(seq.size-3).map{ |c| [first]+c+[last] }
  valid_subseqs = valid_subseqs.select{|s| seq_valid?(s)}
  # For each valid sub sequence find further valid variations
  valid_subsubseqs = valid_subseqs.map{|ss| count_subseqs(ss)}
  result += valid_subsubseqs.flatten(1) unless valid_subsubseqs.empty?
  # Multiple paths may lead to duplicate solutions for a given sequence
  result.uniq
end
# Note that a more brute force approach could be applied finding valid varients
# of increasingly smaller size itteratively but if the initial size of the sequence
# is large this is likely to be less efficient as more and more invalid paths will be reconsidered in each sequence generation.

# Break down adapter sequence at boundary conditions
slices = adapters.slice_when { |i, j| j-i == 3 }.to_a

# Compute in hash for easier debugging
h = {}
slices.each do |slice|
  h[slice] = count_subseqs(slice)
end

pp h.values.map(&:count).inject(:*)
