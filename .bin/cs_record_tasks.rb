#!/usr/bin/env ruby
## CHANGE THIS TO THE FOLDER WHERE YOU WANT TO STORE YOUR FILE ##
filepath="/Users/alex/Desktop/   /Computer Science/IA/"

## DO NOT MODIFY UNDER THIS COMMENT
require 'date'
print "Do you have a date? (y/n) "
if (gets.chomp=="y")
	print "Enter the date (y-m-d): "
	date=gets.chomp
else
	date=Date.today.to_s
end

print "Enter your task: "
task=gets.chomp

finalpath="#{filepath}record_of_tasks.csv"
File.open(finalpath, 'a') { |file| 
	file.puts("#{date},#{task}") 
}