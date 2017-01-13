require "discogs-wrapper"

my_user_token = ENV["DISCOGS_API_TOKEN"]

query="#{ARGV[0]} #{ARGV[1]} #{ARGV[2]}"
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: my_user_token)
search=wrapper.search("#{query}")
search.results.each do |result|
  if result.style? && !result.style.empty?
    p result.style.to_a
    exit
  end
end
