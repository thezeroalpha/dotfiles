#!/usr/bin/env ruby
require 'uri'
require 'net/http'
require 'json'
require 'time'

%w[FLATASTIC_API_KEY FLATASTIC_USER_ID].each do |env_var|
  abort "#{env_var} not set in environment" unless ENV.key? env_var
end

my_user_id = ENV['FLATASTIC_USER_ID'].to_i
api_key = ENV['FLATASTIC_API_KEY']

headers = {
  'accept' => 'application/json, text/plain, */*',
  'origin' => 'https://app.flatastic-app.com',
  'referer' => 'https://app.flatastic-app.com/',
  'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
  'x-api-key' => api_key,
  'x-api-version' => '2.0.0',
  'x-client-version' => '2.3.35'
}

base_url = URI 'https://api.flatastic-app.com'
https = Net::HTTP.new(base_url.host, base_url.port)
https.use_ssl = true

url = "#{base_url}/index.php/api/chores"
resp = JSON.parse(https.get(url, headers).body)
my_tasks = resp
           .select { _1['currentUser'] == my_user_id }
           .map { {'description' => _1['title'],
                    'scheduled_due_date' => Time.at(Time.now.to_i + _1['timeLeftNext']), # close enough
                    'point_value' => _1['points']} }

print my_tasks.to_json
