require "discogs-wrapper" # Needed for API access

# Remove this if sharing. This is required and unique for each user.
my_user_token = ENV["DISCOGS_API_TOKEN"]

flag=ARGV.shift # Whether searching for genre or style
query=ARGV.join(" ") # Join the rest of the arguments into a search string

# Search, and wrap the results in an array
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: my_user_token)
res=[]
search=wrapper.search("#{query}")

# If searching for a genre
if (flag=="g")
  search.results.each do |result|
    if result.genre? && !result.genre.empty?
      result.genre.each do |g|
        res.push("#{g}")
      end
      p res
      break
    end
  end
  # If searching for a style
elsif (flag=="s")
  search.results.each do |result|
    if result.style? && !result.style.empty?
      result.style.to_a.each {|x| res.push "#{x}"}
    end
    p res
    break
  end
  # If searching for url
else
  res="http://discogs.com#{search.results[0].uri}".split(" ")
  p res
end