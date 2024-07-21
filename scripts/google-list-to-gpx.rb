#!/usr/bin/env ruby
# This script lets you generate a GPX from a Google Maps list.
# Steps:
# 1. Log in to maps.google.com
# 2. Open web console network inspector
# 3. Click on whatever list you want
# 4. Find the 'getlist' request in the inspector, copy the response body and
#    paste it as input to this script.
require 'time'
require 'json'
require 'erb'

content = ARGF.readlines
until content.empty?
  begin
    data = JSON.parse content.join
    break
  rescue JSON::ParserError
    content.shift
  end
end

mylist = data.first
listname = mylist[4]

places = mylist[8]

places = places.reduce([]) do |arr, p|
  arr << {name: p[2],
   addr: p[1][4],
   gps: {lat: p[1][5][2], lon: p[1][5][3]},
   desc: p[3],
  }
end

timenow = Time.now.utc.iso8601
header = <<EOF
<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<gpx version="1.1" creator="OsmAnd~ 4.7.10" xmlns="http://www.topografix.com/GPX/1/1" xmlns:osmand="https://osmand.net" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
  <metadata>
    <name>#{listname}</name>
  </metadata>
EOF

footer = <<EOF
  <extensions>
    <osmand:points_groups>
      <group name="#{listname}" color="#ab47bc" icon="special_star" background="circle" />
    </osmand:points_groups>
  </extensions>
</gpx>
EOF

puts header
places.each do |place|
  puts <<EOF
  <wpt lat="#{place[:gps][:lat]}" lon="#{place[:gps][:lon]}">
    <time>#{timenow}</time>
    <name>#{place[:name]}</name>
    <desc>#{place[:desc]}</desc>
    <type>#{listname}</type>
    <extensions>
      <osmand:address>#{place[:addr]}</osmand:address>
      <osmand:color>#26a69a</osmand:color>
      <osmand:background>circle</osmand:background>
      <osmand:icon>special_star</osmand:icon>
    </extensions>
  </wpt>
EOF
end
puts footer
