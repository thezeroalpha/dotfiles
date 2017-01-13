require "discogs-wrapper"

my_user_token = ENV["DISCOGS_API_TOKEN"]

query="#{ARGV[0]} #{ARGV[1]}"
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: my_user_token)
search=wrapper.search("#{query}")
search.results.each do |result|
  if result.style?
    puts result.style[0]
    break
  end
end
