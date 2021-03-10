#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

EMPTY_SEAT = 'L'
PERSON = '#'
FLOOR  = '.'
ADJ_VEC = [[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]]

map = input.split("\n").map{|row| row.split('')}
MAX_COLS = map[0].size
MAX_ROWS = map.size

def in_map_bounds?(c,r)
  c >=0 && r >=0 && c<MAX_COLS && r<MAX_ROWS
end

def count_visible_people(map, col, row)
  person_count = 0
  ADJ_VEC.each do |vec|
    c = col
    r = row
    begin
      c += vec[0]
      r += vec[1]
    end while in_map_bounds?(c,r) && map[r][c] == FLOOR
    person_count += 1 if in_map_bounds?(c,r) && map[r][c] == PERSON
  end
  person_count
end

def iterate_people(map)
  new_map = []
  (0...map[0].size).each do |col|
    (0...map.size).each do |row|
      new_map[row] ||= []
      adj_occupancy = count_visible_people(map, col, row)
      # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
      if map[row][col] == EMPTY_SEAT && adj_occupancy == 0
        new_map[row][col] = PERSON
      # If a seat is occupied (#) and five or more seats adjacent to it are also occupied, the seat becomes empty.
      elsif map[row][col] == PERSON && adj_occupancy >= 5
        new_map[row][col] = EMPTY_SEAT
      else
        new_map[row][col] = map[row][col]
      end
    end
  end
  new_map
end

new_map = iterate_people(map)
while map != new_map
  map = new_map
  print '.'
  new_map = iterate_people(map)
end

pp map.map{|row| row.count(PERSON)}.inject(&:+)
