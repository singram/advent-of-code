#!/usr/bin/env ruby

file_path = File.expand_path("../day-05-input.txt", __FILE__)
input     = File.read(file_path)

def decode_ticket(t)
  res = {t: t, row: 0, col: 0, id: 0}
  row_code, col_code = t.match(/(\w{7})(\w{3})/).captures
  res[:row] = decode_pos((0..127).to_a, row_code)
  res[:col] = decode_pos((0..7).to_a, col_code)
  res[:id] = (res[:row]*8) + res[:col]
  res
end

def decode_pos(arr, code)
  return arr[0] if arr.size == 1
  dir = code.slice!(0)
  half = arr.count/2
  new_arr = (dir == 'F' || dir == 'L') ? arr.slice(0,half) : arr.slice(half, half)
  decode_pos(new_arr, code)
end

tickets = input.split("\n").map{|t| decode_ticket(t)}
ticket_ids = tickets.map{|t|t[:id]}
ticket_id_range = (ticket_ids.min..ticket_ids.max).to_a
puts ticket_id_range - ticket_ids
