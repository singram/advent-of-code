#!/usr/bin/env ruby

file_path = File.expand_path("../day-16-input.txt", __FILE__)
input     = File.read(file_path)

input = input.split('').map{|hex| hex.to_i(16).to_s(2).rjust(hex.size*4, '0')}.join.split('')

class Packet
    attr_accessor :version, :type, :sub_packets, :litteral

    def initialize(input)
        self.version  = input.shift(3).join.to_i(2)
        self.type     = input.shift(3).join
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
        self.type.to_i(2) == 4
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
pp p.version_total