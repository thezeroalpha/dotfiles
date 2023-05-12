#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'

%w[OURHOME_CLIENT_ID OURHOME_USER OURHOME_PASS].each do |env_var|
  abort "#{env_var} not set in environment" unless ENV.key? env_var
end

client_header = "ClientID: #{ENV['OURHOME_CLIENT_ID']}"
user = ENV['OURHOME_USER']
pass = ENV['OURHOME_PASS']
headers = {
  'AUTHORIZATION' => client_header,
  'Content-Type' => 'application/json',
  'Origin' => 'https://app.ourhomeapp.com',
  'Referer' => 'https://app.ourhomeapp.com/',
  'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
  'X-AUTHORIZATION' => client_header,
  'X-CSRFToken' => '{{csrf_token}}'
}

uri = URI 'https://api.ourhomeapp.com'
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true

data = { email: user, password: pass }
resp = https.post('/api/v1/users/login/', data.to_json, headers)

abort 'Request error' if resp.code_type != Net::HTTPOK

cookie = resp['set-cookie']
body = JSON.parse resp.body
me = body['id']
headers['Cookie'] = cookie

uri.path = '/api/v1/tasks/'
query = { is_active: true, sorting: true, user_id: body['id'], is_event: false, list: 'T' }
uri.query = URI.encode_www_form(query)
resp2 = https.get(uri, headers)
body = JSON.parse resp2.body
my_tasks = (body['objects']
  .select { _1['currently_assigned_user'] =~ %r{/#{me}/} && _1['list'] == 'T' }
  .map { _1.select { |k, _v| %w[description scheduled_due_date point_value].include? k } })

print my_tasks.to_json
