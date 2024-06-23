#!/usr/bin/env ruby
require 'nokogiri'
contents = Nokogiri::HTML.fragment ARGF.read
paragraphs = contents.children.reject(&:comment?).map { |line| line.text.strip }
print paragraphs.join "\n\n"
