#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split('').map{|hex| hex.to_i(16).to_s(2).rjust(hex.size*4, '0')}.join.split('')

class Packet
    attr_accessor :version, :type, :sub_packets, :litteral

    def initialize(input)
        self.version  = input.shift(3).join.to_i(2)
        self.type     = input.shift(3).join.to_i(2)
        self.sub_packets = []
        if type_litteral?
            self.litteral = parse_number(input) 
        else
            length_id_type = input.shift
            if length_id_type == '0'
                # If the length type ID is 0, then the next 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
                total_bit_length = input.shift(15).join.to_i(2)
                bits = input.shift(total_bit_length)
                while(bits.any?{|b|b=='1'})
                    self.sub_packets << Packet.new(bits)
                end
            else
                # If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
                total_subpackets = input.shift(11).join.to_i(2)
                total_subpackets.times do
                    self.sub_packets << Packet.new(input)
                end
            end
        end
    end

    def type_litteral?
        self.type == 4
    end

    def evaluate
        result = nil
        if type_litteral?
            result = self.litteral
        else
            parts = self.sub_packets.map(&:evaluate)
            if self.type == 0
                # Packets with type ID 0 are sum packets - their value is the sum of the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
                result = parts.sum
            elsif self.type == 1
                # Packets with type ID 1 are product packets - their value is the result of multiplying together the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
                result = ([1]+parts).inject(&:*)
            elsif self.type == 2
                # Packets with type ID 2 are minimum packets - their value is the minimum of the values of their sub-packets.
                result = parts.min
            elsif self.type == 3
                # Packets with type ID 3 are maximum packets - their value is the maximum of the values of their sub-packets.
                result = parts.max
            elsif self.type == 5
                # Packets with type ID 5 are greater than packets - their value is 1 if the value of the first sub-packet is greater than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
                result = parts[0] > parts[1] ? 1 : 0
            elsif self.type == 6
                # Packets with type ID 6 are less than packets - their value is 1 if the value of the first sub-packet is less than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
                result = parts[0] < parts[1] ? 1 : 0
            elsif self.type == 7
                # Packets with type ID 7 are equal to packets - their value is 1 if the value of the first sub-packet is equal to the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
                result = parts[0] == parts[1] ? 1 : 0
            end
        end
        result
    end
              
    def parse_number(input, number=[])
        last_bit = input.shift == '0'
        number << input.shift(4)
        parse_number(input, number) if !last_bit 
        number.join.to_i(2)
    end

    def version_total
        self.version + sub_packets.map{|sp| sp.version_total}.sum
    end
end

p = Packet.new(input)
pp p.evaluate