#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'tempfile'

if ARGV.empty?
  print "Enter url: "
  url = gets.chomp
else
  url = ARGV[0]
end

if ! URI.parse(url).host.downcase.include? 'medium.com'
  abort "Not a Medium page."
end
doc = Nokogiri(open url)

f = Tempfile.new(['article', '.html'])
begin
  f.puts "<!DOCTYPE html><html><head>"
  doc.css('head meta').each do |e|
    f.puts e.to_html
  end
  doc.css('head link').each do |e|
    f.puts e.to_html
  end
  f.puts doc.css('head title').first.to_html
  f.puts "</head><body>"
  doc.css('main div.section-content').each do |e|
    f.puts e.to_html
  end
  f.puts "</body></html>"

  `open 'file://#{f.path}' && sleep 5`
ensure
  f.close
  f.unlink
end
