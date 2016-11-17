#!/usr/bin/env ruby
## CHANGE THIS TO THE FOLDER WHERE YOU WANT TO STORE YOUR FILE ##
filepath="/Users/alex/Desktop/   /Computer Science/"

## DO NOT MODIFY UNDER THIS COMMENT
require 'date'
date=Date.today.to_s

print "Who did he roast now: "
roastee=gets.chomp
print "Enter roast: "
roast=gets.chomp

finalpath="#{filepath}popa-savage-quotes.csv"
File.open(finalpath, 'a') { |file| 
	file.puts('#{date},#{roastee},"#{roast}"') 
}
puts "Roasted."