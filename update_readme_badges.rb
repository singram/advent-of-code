#!/usr/bin/env ruby
require 'net/http'
require 'cgi'
require 'json'
require 'date'

USER_ID     = ENV['USER_ID']
SESSION_ID  = ENV['SESSION_ID']
START_TOKEN = ENV['START_TOKEN'] || "<!--START_SECTION:stats-->"
END_TOKEN   = ENV['END_TOKEN'] || "<!--END_SECTION:stats-->"
README      = ENV['README'] || 'README.md'

data = {}
years =  Dir.glob('*').select {|f| File.directory?(f) && f =~ /\d{4}/}

begin
    years.each do |year|
        uri = URI("https://adventofcode.com/#{year}/leaderboard/private/view/#{USER_ID}.json")
        req = Net::HTTP::Get.new(uri)
        req[:Cookie] = CGI::Cookie.new('session', SESSION_ID).to_s
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) {|http| http.request(req) }
        body = JSON.parse(res.body)
        times = body['members'][USER_ID]['completion_day_level'].flat_map{|day, info| info.map{|day, day_data| day_data['get_star_ts']} }
        data[year.to_i] = { 
            stars: body['members'][USER_ID]['stars'],
            days: body['members'][USER_ID]['completion_day_level'].count{|day, info| info.size == 2},
            first: times.min,
            last: times.max
        }
    end
rescue => e
    data = nil
    pp e
end

if data
    stats_insert  = "\n| Year | Attempt between 📅| Stats |\n"
    stats_insert += "| ---- | ---- | ---- |\n"
    data.keys.sort.each do |year|
        stats = data[year]
        stats_insert += "| #{year} "
        stats_insert += "| #{Time.at(stats[:first]).strftime("%B %e, %Y")} "
        stats_insert += "-> #{Time.at(stats[:last]).strftime("%B %e, %Y")} | "
        stats_insert += " ![](https://img.shields.io/badge/Stars%20⭐-#{stats[:stars]}-yellow) "
        stats_insert += " ![](https://img.shields.io/badge/Days%20completed-#{stats[:days]}-red) | \n"
    end
    stats_insert += "\n<sub>*(updated @ #{Time.now}). Inspired by [AoC-badges](https://github.com/J0B10/aoc-badges-action)*</sub>\n"
    
    readme = File.open(README).read
    readme.sub!(/#{START_TOKEN}.*#{END_TOKEN}/mi, "#{START_TOKEN}#{stats_insert}#{END_TOKEN}")
    File.write(README, readme)
end

