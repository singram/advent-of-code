#!/usr/bin/env ruby

file_path = File.expand_path("../day-20-input.txt", __FILE__)
input     = File.read(file_path)

decoder, image_input = input.split("\n\n")

decoder = decoder.split('')

ON = '#'
OFF = '.'

image = image_input.split("\n").map{|line| line.split('')}

def remove_border!(input)
    input.slice!(0)
    input.slice!(-1)
    input.map!{|line| line.slice(1,line.size-2)}
end

def add_border!(input, infinity)
    input.map!{|line| [infinity] + line + [infinity]}
    input.unshift(Array.new(input[0].size){infinity})
    input.push(Array.new(input[0].size){infinity})
    input
end

def decode_pixel(image, x, y, decoder)
    ref  = image[y-1].slice(x-1,3)
    ref += image[y  ].slice(x-1,3)
    ref += image[y+1].slice(x-1,3)
    ref_raw = ref
    ref  = ref.map{|c| c==ON ? '1' : '0'}.join.to_i(2)
    decoder[ref]
end

add_border!(image, OFF)
add_border!(image, OFF)

50.times do |i|
    new_image = Array.new(image.size){Array.new(image[0].size){'.'}}
    (1...image.size-1).each do |y|
        (1...image[0].size-1).each do |x|
            new_image[y][x] = decode_pixel(image, x, y, decoder)
        end
    end
    image = new_image
    remove_border!(image)

    infinity = i%2 == 0 ? ON : OFF  # Input flips infinity between # and . (see decoder[0] & decoder[512])
    add_border!(image, infinity)
    add_border!(image, infinity)
end

pp image.map{|line| line.count(ON)}.sum

