#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'rexml'
require 'io/console'

print 'email: '
email = gets.chomp
print 'pass: '
password = $stdin.noecho(&:gets).chomp

# For windows see here https://github.com/MaikEight/ExaltAccountManager/blob/9435db6c63a4fb6fd93e594d1cff7a7879b35bb1/EAM%20Daily%20Login%20Service/DailyLogin.cs#L706
unique_id = `ioreg -d2 -c IOPlatformExpertDevice | awk -F\\" '/IOPlatformUUID/{printf $(NF-1)}'`

def send_req(url, form_data)
  url = URI(url)
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  req = Net::HTTP::Post.new url.path
  req.content_type = 'application/x-www-form-urlencoded'
  req.set_form_data(form_data)
  https.request(req)
end

puts 'Logging in...'
values = {
  guid: email,
  password: password,
  clientToken: unique_id,
  game_net: 'Unity',
  play_platform: 'Unity',
  game_net_user_id: ''
}

response = send_req('https://www.realmofthemadgod.com/account/verify', values)
abort 'Error in getting access token' unless response.code_type == Net::HTTPOK

doc = REXML::Document.new response.body
access_token = doc.elements['/Account/AccessToken'].text
values = {
  do_login: 'false',
  accessToken: access_token,
  game_net: 'Unity',
  play_platform: 'Unity',
  game_net_user_id: '',
  muleDump: 'true',
  __source: 'jakcodex-v965'
}

response = send_req('https://www.realmofthemadgod.com/char/list', values)
abort 'Error in getting login' unless response.code_type == Net::HTTPOK

puts response.body
