#!/usr/bin/env ruby
# Parses a Hangouts.json file downloaded from Google Hangouts
require 'json'
File.open("Hangouts.json") do |f|
  t=JSON.parse(f.read)
  t["conversations"].each do |conv|
    sender_1 = { name: conv["conversation"]["conversation"]["participant_data"].first["fallback_name"], id: conv["conversation"]["conversation"]["participant_data"].first["id"] }
    sender_2 = { name: conv["conversation"]["conversation"]["participant_data"][1]["fallback_name"], id: conv["conversation"]["conversation"]["participant_data"][1]["id"] }
    puts "#{sender_1[:name]} & #{sender_2[:name]}"
    conv['events'].each do |evt|
      evt['chat_message']['message_content']['segment'].each do |seg|
        print "#{(sender_1[:id] == evt['sender_id'] ? sender_1[:name].split.first : sender_2[:name].split.first)}: "
        puts seg['text']
      end
    end
    10.times { print "#" }
    puts
  end
end
