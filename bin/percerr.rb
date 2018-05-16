#!/usr/bin/env ruby

puts "Welcome to the Percent Error Calculator."
print "What is your estimated value? >> "
estimated=gets.chomp.to_f
print "What is your measured value? >> "
measured=gets.chomp.to_f

if estimated>measured
	err=estimated-measured
else
	err=(estimated-measured)*-1
end

puts "Your error is " + err.to_s + "."

percerr=(err/measured)*100

puts "Your percent error is " + percerr.to_s + "%."
puts "Rounded, this is " + percerr.round().to_s + "%."