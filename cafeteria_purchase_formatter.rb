#!/usr/bin/ruby
gem 'date_converter'
require 'date_converter'

filename=ARGV[0]
lines=File.readlines("#{filename}")
newlines = []

lines.each do |text|
  replace=text.gsub(/(^.+)[A|P]M/,'\1')
  replace=replace.gsub(/(\d{4})\sat\s\d{2}:\d{2},(.*$)/,'\1,\2')
  arr = replace.scan(/\w+\s\d{1,2},\s\d{4}/)
  ar2 = arr.map { |e| DateConverter.verbal_date_to_numeric(e) }

  arr.each_with_index {|e,i| replace = replace.gsub(e,ar2[i])}
  newlines << replace
end

File.open("#{filename}", "w") do |io|
  newlines.each do |line|
    io.puts "#{line.chomp},Assets:Current Assets:Lunch Card Account"
  end
end
