#!/usr/bin/env ruby

file_path = File.expand_path("../day-24-input.txt", __FILE__)
input     = File.read(file_path)

instructions = input.split("\n").map{|l| l.split(' ')}
instructions.map!{|l| [ l[0].to_sym, l[1].to_sym, ['w','x','y','z'].include?(l[2]) ? l[2].to_sym : l[2].to_i ] }

pp instructions

class Monad
    attr_reader :w, :x, :y, :z
    attr_accessor :input

    def initialize
        @save = nil?
        @state = { w: 0, x:0, y:0, z: 0 }
    end

    def save_state
        @save = @state.dup
    end

    def restore_state
        @state = @save
    end

    def instruction (operator, op1, op2=nil)
        case operator
        when :inp
            @state[op1] = input.next
        when :add
            @state[op1] = @state[op1] + ( op2.class == Symbol ? @state[op2] : op2 )
        when :mul
            @state[op1] = @state[op1] * ( op2.class == Symbol ? @state[op2] : op2 )
        when :div
            @state[op1] = @state[op1] / ( op2.class == Symbol ? @state[op2] : op2 )
        when :mod
            @state[op1] = @state[op1] % ( op2.class == Symbol ? @state[op2] : op2 )
        when :eql
            @state[op1] = @state[op1] == @state[op2] ? 1 : 0 
        end
    end

    def to_s
        @state.to_s
    end

#     inp a - Read an input value and write it to variable a.
# add a b - Add the value of a to the value of b, then store the result in variable a.
# mul a b - Multiply the value of a by the value of b, then store the result in variable a.
# div a b - Divide the value of a by the value of b, truncate the result to an integer, then store the result in variable a. (Here, "truncate" means to round the value toward zero.)
# mod a b - Divide the value of a by the value of b, then store the remainder in variable a. (This is also called the modulo operation.)
# eql a b - If the value of a and b are equal, then store the value 1 in variable a. Otherwise, store the value 0 in variable a.
end

x = Monad.new
i = (1..9).reverse_each
x.input = i

x.instruction(*instructions[0])
pp x.to_s
x.instruction(*instructions[1])
pp x.to_s
x.instruction(*instructions[2])
pp x.to_s
x.instruction(*instructions[3])
pp x.to_s
x.instruction(*instructions[4])
pp x.to_s
x.instruction(*instructions[5])
pp x.to_s