#!/usr/bin/env ruby

file_path = File.expand_path("../day-11-input.txt", __FILE__)
input     = File.read(file_path)

# No I did not want to parse this out particularly.
monkeys = {
    0 => {
        items: [85, 77, 77],
        op: ->(old) { old * 7 },
        tst: ->(x)  { x % 19 == 0 },
        dest: ->(t) { t ? 6 : 7}
    },
    1 => {
        items: [80,99],
        op: ->(old) { old * 11 },
        tst: ->(x)  { x % 3 == 0 },
        dest: ->(t) { t ? 3 : 5}
    },
    2 => {
        items: [74, 60, 74, 63, 86, 92, 80],
        op: ->(old) { old + 8 },
        tst: ->(x)  { x % 13 == 0 },
        dest: ->(t) { t ? 0 : 6}
    },
    3 => {
        items: [71, 58, 93, 65, 80, 68, 54, 71],
        op: ->(old) { old + 7 },
        tst: ->(x)  { x % 7 == 0 },
        dest: ->(t) { t ? 2 : 4}
    },
    4 => {
        items: [97, 56, 79, 65, 58],
        op: ->(old) { old + 5 },
        tst: ->(x)  { x % 5 == 0 },
        dest: ->(t) { t ? 2 : 0}
    },
    5 => {
        items: [77],
        op: ->(old) { old + 4 },
        tst: ->(x)  { x % 11 == 0 },
        dest: ->(t) { t ? 4 : 3}
    },
    6 => {
        items: [99, 90, 84, 50],
        op: ->(old) { old * old },
        tst: ->(x)  { x % 17 == 0 },
        dest: ->(t) { t ? 7 : 1}
    },
    7 => {
        items: [50, 66, 61, 92, 64, 78],
        op: ->(old) { old + 3 },
        tst: ->(x)  { x % 2 == 0 },
        dest: ->(t) { t ? 5 : 1}
    }
}

COMMON_PROD = [19,3,13,7,5,11,17,2].inject(&:*)

ROUNDS = 10000

ROUNDS.times do
    monkeys.each do |monkey_id, monkey|
        item_list = monkey[:items]
        monkey[:items] = []
        monkey[:inspection_counter] ||= 0
        item_list.each do |item|
            monkey[:inspection_counter] += 1
            item = monkey[:op].call(item)
            item = item % COMMON_PROD
            monkeys[monkey[:dest].call(monkey[:tst].call(item))][:items] << item
        end
    end
end

pp monkeys.keys.map{|id| monkeys[id][:inspection_counter]}.max(2).inject(&:*)

