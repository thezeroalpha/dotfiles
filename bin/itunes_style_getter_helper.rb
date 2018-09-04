require "discogs-wrapper" # Needed for API access

my_user_token = ENV['DISCOGS_API_TOKEN']

if my_user_token == nil
  raise "No user token set."
end

# Create a wrapper
wrapper=Discogs::Wrapper.new("iTunesStyleGetter", user_token: my_user_token)

# Join the rest of the arguments into a search string
query=ARGV.join(" ")

# Initialise arrays
genres,styles=[],[]

# Search for the query
search=wrapper.search("#{query}")

# Add the genres of the first result
search.results.each do |result|
  if result.genre? && !result.genre.empty?
    result.genre.each do |g| 
      if g.include? ","
	g.split(",").each { |x| genres.push "#{x}" }
      else
	genres.push "#{g}"
      end
    end
    break
  end
end

# Add the styles of the first result
search.results.each do |result|
  if result.style? && !result.style.empty?
    result.style.to_a.each {|x| styles.push "#{x}"}
  end
  break
end

# Add the url of the first result
url = "http://discogs.com#{search.results[0].uri}".split(" ")

# Join everything together into a 2d array
# 2 different separators ("~", ",") because bash
result = [genres.join("~"), styles.join("~"), url]

# Send result to stdout
p result