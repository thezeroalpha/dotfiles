require "discogs-wrapper"

my_user_token = ENV["DISCOGS_API_TOKEN"]


query=ARGV.join(" ")
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: my_user_token)
res=[]
search=wrapper.search("#{query}")
search.results.each do |result|
  if result.style? && !result.style.empty?
    res="http://discogs.com#{result.uri}".split(" ")
    result.style.to_a.each {|x| res.push x }
    break
  end
end
search.results.each do |result|
  if result.genre? && !result.genre.empty?
    result.genre.each do |g|
      res.push("#{g}")
    end
    p res
    exit
  end
end
