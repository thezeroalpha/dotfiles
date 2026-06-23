#!/usr/bin/env ruby
require "json"
require "date"

data = JSON.parse(ARGF.read)

notes = data["bookmarks"].values.sort_by { |x| DateTime.parse(x["datetime"]) }
notes.each do |note|
  print("* #{note["notes"].sub(/@ \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/, "")}\n")
end
