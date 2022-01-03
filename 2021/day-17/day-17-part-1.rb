#!/usr/bin/env ruby

file_path = File.expand_path("../day-17-input.txt", __FILE__)
input     = File.read(file_path)

box = input.match(/target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/).captures.map(&:to_i)

results = {}
(0..1000).each do |y|
    (0..1000).each do |x|
        vel_x = x 
        vel_y = y
        pos_x, pos_y, max_y = 0, 0, 0

        (0..1000).each do
            pos_x += vel_x
            pos_y += vel_y
            max_y = pos_y if pos_y > max_y
            vel_x += vel_x > 0 ? -1 : ( vel_x < 0 ? 1 : 0 )
            vel_y += -1
            if pos_x.between?(box[0],box[1]) && pos_y.between?(box[2],box[3])
                # target hit
                results[max_y] ||= []
                results[max_y] << [x,y]
                break
            elsif pos_x > box[1] || pos_y < box[2]
                # overshot
                break
            end
        end
    end
end

pp results.keys.max