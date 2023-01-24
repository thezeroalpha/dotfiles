# frozen_string_literal: true
# https://getpocket.com/developer/docs/overview
require 'open-uri'
require 'json'
require 'net/http'

def die(message)
  warn "error: #{message}"
  exit 1
end

# The Pocket API authentication system
class PocketAuth
  def initialize
    die 'Please set the POCKET_CONSUMER_KEY environment variable.' unless ENV['POCKET_CONSUMER_KEY']
    @consumer_key = ENV['POCKET_CONSUMER_KEY']
    @base = 'https://getpocket.com/v3'
    @headers = { 'Content-Type' => 'application/json; charset=UTF8', 'X-Accept' => 'application/json' }
    @access_token = read_access_token
  end

  def credentials
    { consumer_key: @consumer_key, access_token: @access_token }
  end

  private

  ACCESS_TOKEN_FILE = "#{ENV['HOME']}/.cache/pocket-access-token"

  def read_access_token
    if File.exist? ACCESS_TOKEN_FILE
      @access_token = File.read ACCESS_TOKEN_FILE
    else
      @access_token = request_access_token
      puts "Writing access token to #{ACCESS_TOKEN_FILE}, remove this file to revoke authorization."
      File.write ACCESS_TOKEN_FILE, @access_token
    end
  end

  def generate_auth_uri
    query = { consumer_key: @consumer_key, redirect_uri: 'https://example.com' }
    response = Net::HTTP.post URI("#{@base}/oauth/request"), query.to_json, @headers
    if response.code == '200'
      @pocket_code = JSON.parse(response.body)['code']
    else
      die 'Could not retrieve code.'
    end
    "https://getpocket.com/auth/authorize?request_token=#{@pocket_code}&redirect_uri=#{query['redirect_uri']}"
  end

  def authenticate
    query = { consumer_key: @consumer_key, code: @pocket_code }
    response = Net::HTTP.post URI("#{@base}/oauth/authorize"), query.to_json, @headers
    return nil unless response.code == '200'

    JSON.parse(response.body)
  end

  def request_access_token
    puts "Please open: #{generate_auth_uri}"
    # TODO: start a temp server, react when receive request (URL passed in redirect_uri above)
    print 'Press enter when done.'
    STDIN.getc
    auth_response = authenticate
    die 'Could not authenticate' unless auth_response
    puts "Authenticated for username #{body['username']}"
    @access_token = body['access_token']
  end
end

# The Pocket API interface class
class Pocket
  def initialize
    @base = 'https://getpocket.com/v3'
    @headers = { 'Content-Type' => 'application/json; charset=UTF8', 'X-Accept' => 'application/json' }
    @security_params = PocketAuth.new.credentials
  end

  def api_call(endpoint, params)
    response = Net::HTTP.post URI(@base+endpoint), params.merge(@security_params).to_json, @headers
    if response.code == '200'
      block_given? ? (yield JSON.load(response.body)) : (return JSON.load(response.body))
    else
      die "Could not add, code #{response.code}"
    end
  end

  def save(url)
    api_call("/add", url: url)
  end

  def retrieve_list(query)
    # merge overwrites sort key if needed
    api_call("/get", { sort: 'newest' }.merge(query)) do |response_body|
      response_body['list'].map { |_id, data| data }
    end
  end
end

