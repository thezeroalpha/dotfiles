#!/usr/bin/ruby
# make this into a library
def verbal_date_to_numeric verbal
  arr = verbal.split(/[\s,]/)
  month=case arr[0]
when "January"
  1
when "February"
  2
when "March"
  3
when "April"
  4
when "May"
  5
when "June"
  6
when "July"
  7
when "August"
  8
when "September"
  9
when "October"
  10
when "November"
  11
when "December"
  12
end

arr[0]=month

  # 11, "17","2016"

  arr.map { |e| e.to_i unless e.is_a? Integer }

  # 11, 17, 2016
  #
  arr[0], arr[1], = arr[1], arr[0]

  # 17, 11, 2016

  arr.delete_at(2)
  return arr.join("-")
end

filename=ARGV[0]
lines=File.readlines("#{filename}")
newlines = []

lines.each do |text|
  replace=text.gsub(/(^.+)[A|P]M/,'\1')
  replace=replace.gsub(/(\d{4})\sat\s\d{2}:\d{2},(.*$)/,'\1,\2')
  arr = replace.scan(/\w+\s\d{1,2},\s\d{4}/)
  ar2 = arr.map { |e| verbal_date_to_numeric(e) }

  arr.each_with_index {|e,i| replace = replace.gsub(e,ar2[i])}
  newlines << replace
end

File.open("#{filename}", "w") do |io|
  newlines.each do |line|
    io.puts "#{line.chomp},Assets:Current Assets:Lunch Card Account"
  end
end
