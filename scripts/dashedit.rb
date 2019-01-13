#!/usr/bin/env ruby
require 'json'
require 'rest-client'

class DashSubmit
    attr_accessor :deliverable_id

    def initialize deliverable_id
        @deliverable_id = deliverable_id
        @base_uri = "https://submit.dashnet.tech"
        @bearer_code = ENV['DASHNET_CODE']
        @user = ENV['DASHNET_USER']
        @headers = {
            "Accept": "application/json, text/plain, */*",
            "Authorization": @bearer_code,
            "Origin": "https://dashnet.tech"
        }
    end

    def get_status
        puts "#{@base_uri}/user/#{@user}/submissions"
        response = RestClient.get(
            "#{@base_uri}/user/#{@user}/submissions",
            @headers
        )
        response = JSON.parse(response)

        if response["success"]
            data = response["data"][0]
            puts "Waiting..."
            while data['test_status'] == "waiting"
                response = RestClient.get(
                    "#{@base_uri}/user/#{@user}/submissions",
                    @headers
                )
                response = JSON.parse(response)
                data = response["data"][0]
            end
            puts "Filename: #{data["filename"]}"
            puts "Attempt: #{data['attempt']}"
            puts "Result: #{data["test_status"]}"
            puts "Output:"
            puts data["test_output"]
        else
            puts "Request fucked up."
        end
    end
    def submit path
        extra_headers = {
            "Content-Type": "multipart/form-data; boundary=---011000010111000001101001",
        }
        request = RestClient::Request.new(
            method: :post,
            url: "#{@base_uri}/deliverables/#{@deliverable_id}",
            headers: @headers.merge(extra_headers),
            payload: {
                multipart: true,
                file: File.new(path, "rb")
            })
        response = JSON.parse(request.execute)

        if response["success"]
            data = response["data"]
            puts "Submitted successfully!"
            puts "File: #{path}"
            puts "Filename: #{data["filename"]}"
            puts "Checksum: #{data["checksum"]}"
        end
    end
end

if ENV['DASHNET_CODE'].nil?
    puts "Please set the $DASHNET_CODE environment variable in your profile."
    puts "You can find this using the Web Inspector in your browser. Record the XHR request, find the 'authorization' field, and copy the string starting with 'Bearer'."
elsif ENV['DASHNET_USER'].nil?
    puts "Please set the $DASHNET_USER environment variable in your profile to your DashNet username (VUnet ID)."
else
    deliverable_id = "13356ed0-e21d-42a2-804d-301102b5b40b"
    submitter = DashSubmit.new(deliverable_id)
    if ARGV[0] == "status"
        submitter.get_status
    elsif ARGV[0] == "submit"
        if !ARGV[1].nil?
            submitter.submit ARGV[1]
        else
            puts "Please provide a path."
        end
    else
        puts "Usage:"
        puts "  dashedit submit $path"
        puts "  dashedit status"
    end
end

