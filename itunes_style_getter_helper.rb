require "discogs-wrapper"

query="#{ARGV[0]} #{ARGV[1]}"
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: "uTZcIvlAFxZzteceXTKJlZLRgSJhbiJCOBIjZIbx")
search=wrapper.search("#{query}")
search.results.each do |result|
  if result.style?
    puts result.style[0]
    break
  end
end
