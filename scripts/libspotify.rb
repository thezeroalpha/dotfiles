#!/usr/bin/env ruby
require "uri"
require "net/http"
require "openssl"
require "json"
require "date"
require "yaml"
require "webrick"

# Add easy access to hash members for JSON stuff
class Hash
  def method_missing(meth, *_args, &_block)
    raise NoMethodError unless key?(meth.to_s)

    self[meth.to_s]
  end
end

require "securerandom"
require "digest"
require "base64"

# Client to access Spotify
class SpotifyClient
  CLIENT_ID = "c747e580651248da8e1035c88b3d2065"
  REDIRECT_URI = "http://localhost:4815/callback"

  # OAUTH functions
  def self.generate_random_string(length)
    possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    values = SecureRandom.random_bytes(length).bytes
    values.reduce("") { |acc, x| acc + possible[x % possible.length] }
  end

  def auth_refresh_token(refresh_token)
    url = URI("https://accounts.spotify.com/api/token")
    body = {
      grant_type: :refresh_token,
      refresh_token: refresh_token,
      client_id: CLIENT_ID
    }
    request = Net::HTTP::Post.new(url)
    request.body = URI.encode_www_form(body)
    request.content_type = "application/x-www-form-urlencoded"
    http = Net::HTTP::new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request)
    resp = JSON.parse(response.read_body)
    store_refresh_token(resp["refresh_token"])
    return resp["access_token"]
  end

  def auth_obtain_code(state, code_challenge)
    scope = %w[
      user-read-private
      playlist-read-collaborative
      playlist-modify-public
      playlist-modify-private
      streaming
      ugc-image-upload
      user-follow-modify
      user-follow-read
      user-library-read
      user-library-modify
      user-read-private
      user-read-email
      user-top-read
      user-read-playback-state
      user-modify-playback-state
      user-read-currently-playing
      user-read-recently-played
    ]
      .join(" ")
    params = {
      client_id: CLIENT_ID,
      response_type: :code,
      scope: scope,
      show_dialog: false,
      redirect_uri: REDIRECT_URI,
      state: state,
      code_challenge_method: :S256,
      code_challenge: code_challenge
    }
    url = URI("https://accounts.spotify.com/authorize")
    url.query = URI.encode_www_form(params)

    server = WEBrick::HTTPServer.new(
      Port: 4815,
      Logger: WEBrick::Log.new("/dev/null"),
      AccessLog: []
    )
    server.mount_proc("/callback") do |req, res|
      res.status = 200
      abort("Mismatched state") if req.query["state"] != state
      @auth_code = req.query["code"]
      server.stop
    end

    t = Thread.new { server.start }
    puts("If it doesn't open automatically, open this in your browser:\n#{url}")
    system("open", url)
    t.join
  end

  def auth_request_token(state, code_verifier)
    url = URI("https://accounts.spotify.com/api/token")
    body = {
      grant_type: :authorization_code,
      code: @auth_code,
      redirect_uri: REDIRECT_URI,
      client_id: CLIENT_ID,
      code_verifier: code_verifier
    }
    request = Net::HTTP::Post.new(url)
    request.body = URI.encode_www_form(body)
    request.content_type = "application/x-www-form-urlencoded"
    http = Net::HTTP::new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request)
    resp = JSON.parse(response.read_body)
    store_refresh_token(resp["refresh_token"])
    return resp["access_token"]
  end

  # Carry out OAUTH authorization with PKCE flow
  def auth_obtain_token
    code_verifier = SpotifyClient.generate_random_string(64)
    code_challenge = Base64.strict_encode64(Digest::SHA256.digest(code_verifier)).tr("+/", "-_").gsub("=", "")

    state = Base64.strict_encode64(Digest::SHA256.digest(SpotifyClient.generate_random_string(64)))
    auth_obtain_code(state, code_challenge)
    abort("No auth code") if @auth_code.nil?
    return auth_request_token(state, code_verifier)
  end

  def get_refresh_token
    `security find-generic-password -a spotify -s spotify_refresh_token -w`
  end

  def store_refresh_token(token)
    system("security add-generic-password -a spotify -s spotify_refresh_token -w \"#{token}\"")
  end

  def auth
    refresh_token = get_refresh_token

    if refresh_token.empty?
      @token = auth_obtain_token
    else
      @token = auth_refresh_token(refresh_token)
    end
  end

  def initialize
    auth
    @base_url = URI("https://api.spotify.com/v1/")
    @http = Net::HTTP.new(@base_url.host, @base_url.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def api_call_get(endpoint, params = {})
    url = @base_url + endpoint
    url.query = URI.encode_www_form(params)
    url_call_get(url)
  end

  def api_call_post(endpoint, body)
    url = @base_url + endpoint
    url_call_post(url, body)
  end

  def api_call_put(endpoint, body, params = {})
    url = @base_url + endpoint
    url.query = URI.encode_www_form(params)
    url_call_put(url, body)
  end

  def url_call_get(url)
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{@token}"
    begin
      resp = @http.request(request)
    rescue
      puts("Connection broke, retrying request to #{url}")
      sleep(2)
      return url_call_get(url)
    end

    if resp.code_type == Net::HTTPTooManyRequests
      wait_seconds = resp["Retry-After"].to_i
      wait_min = wait_seconds / 60
      if wait_min > 30
        puts("Rate limited to wait more than half an hour (#{wait_min} min), exiting")
        exit(1)
      end

      # Wait and retry
      sleep(wait_seconds)
      return url_call_get(url)
    elsif resp.code_type != Net::HTTPOK
      puts("Request #{url} returned #{resp}")
      exit(1)
    end

    JSON.parse(resp.read_body)
  end

  def url_call_post(url, body)
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{@token}"
    request.body = JSON.dump(body)
    request.content_type = "application/json"
    JSON.parse(@http.request(request).read_body)
  end

  def url_call_put(url, body)
    request = Net::HTTP::Put.new(url)
    request["Authorization"] = "Bearer #{@token}"
    request.body = JSON.dump(body)
    request.content_type = "application/json"
    response_body = @http.request(request).read_body
    response_body.nil? ? nil : JSON.parse(response_body)
  end

  def api_call_get_unpaginate(endpoint, params, results_key = nil)
    res = api_call_get(endpoint, params)
    return res if res.key?("error")

    if results_key.nil?
      data = res.items
      url = res.next

      until url.nil?
        res = url_call_get(url)
        data += res.items
        url = res.next
      end
    else
      data = res[results_key].items
      url = res[results_key].next

      until url.nil?
        res = url_call_get(url)
        data += res[results_key].items
        url = res[results_key].next
      end
    end

    data
  end

  def get_followed_artists
    api_call_get_unpaginate("me/following", {type: :artist, limit: 50}, "artists")
  end

  def get_artists_releases(artists)
    total = artists.size
    print("Processing 0/#{total}")
    releases = artists
      .each
      .with_index
      .reduce([]) do |acc, (artist, i)|
        print("\rProcessing #{i + 1}/#{total}")
        response = api_call_get(
          "artists/#{artist.id}/albums",
          {limit: 50, include_groups: "album,single,appears_on"}
        )
        albums = response.items
        albums.each { |album|
          album["release_date"] = album.release_date.split("-").size == 1 ? Date.iso8601("#{album.release_date}-01") : Date
            .iso8601(album.release_date)
        }
        acc + albums
      end
      .reject { |album| album.album_type == "compilation" }
    print("\n")

    puts("Sorting")
    releases.sort_by(&:release_date)
  end

  def add_to_playlist_if_not_present(playlist_id, tracks)
    playlist_track_uris = api_call_get_unpaginate("playlists/#{playlist_id}/tracks", {limit: 50}).map { |x|
      x.track.uri
    }
    track_uris = tracks.map { _1[:uri] }
    to_add = track_uris.reject { |t| playlist_track_uris.include?(t) }
    puts("Adding #{to_add.size} new tracks to playlist.")
    to_add.each_slice(100) do |uris_slice|
      body = {:"uris" => uris_slice}
      api_call_post("playlists/#{playlist_id}/tracks", body)
    end
  end
end

def playlist_overview(
  playlist_id
  # to download:
  # playlist_id = '52qgFnbZwV36ogaGUquBDt'
)
  client = SpotifyClient.new
  playlist_tracks = client.api_call_get_unpaginate("playlists/#{playlist_id}/tracks", {limit: 50})
  by_artist = playlist_tracks.group_by { _1.track.artists.first.name }
  by_artist_album = by_artist.reduce({}) { |h, (artist, tracks)|
    h[artist] = tracks.group_by { |t| t.track.album.name }
    h
  }
  res = by_artist_album.reduce({}) do |h, (artist, albums)|
    h[artist] = albums.reduce({}) do |h2, (album, tracks)|
      h2[album] = tracks.map { |track| track.track.name }.uniq
      h2
    end

    h
  end

  puts(JSON.dump(res))
end

# Process new releases since the date in ~/.local/share/spot-last-checked, add
# them to a tracks or albums playlist.
def process_new_releases(interactive = true)
  tracks_playlist = "4agx19QeJFwPQRWeTViq9d"
  albums_playlist = "2qYpNB8LDicKjcm5Px1dDQ"

  client = SpotifyClient.new
  artists = client.get_followed_artists
  releases = client.get_artists_releases(artists)
  last_checked = YAML.load_file("#{ENV["HOME"]}/.local/share/spot-last-checked", permitted_classes: [Date, Symbol])
  albums, others = releases.select { |r| r.release_date >= last_checked }.partition { |x| x.album_type == "album" }

  albums_tracks = albums.reduce([]) do |acc, album|
    album_tracks = client.api_call_get_unpaginate("albums/#{album.id}/tracks", {limit: 50})
    album_tracks.each { |track| track["album"] = album["name"] }
    acc + album_tracks
  end

  others_tracks = others.reduce([]) do |acc, album|
    album_tracks = client.api_call_get_unpaginate("albums/#{album.id}/tracks", {limit: 50})
    album_tracks.each { |track| track["album"] = album["name"] }
    acc + album_tracks
  end

  if interactive
    trackfile = Tempfile.create
    trackfile_path = trackfile.path
    albumfile = Tempfile.create
    albumfile_path = albumfile.path

    albums_tracks.each do |t|
      albumfile.puts([t.artists.map(&:name).join(", "), t.name, t.album, t.uri].join("\t"))
    end

    others_tracks.each do |t|
      trackfile.puts([t.artists.map(&:name).join(", "), t.name, t.album, t.uri].join("\t"))
    end

    trackfile.close
    albumfile.close

    system("nvim", "-o", albumfile_path, trackfile_path)

    trackfile = File.open(trackfile_path, "r")
    albumfile = File.open(albumfile_path, "r")
    albums_tracks = albumfile.readlines.map { {uri: _1.chomp.split("\t").last} }
    others_tracks = trackfile.readlines.map { {uri: _1.chomp.split("\t").last} }

    trackfile.close
    albumfile.close
    File.unlink(trackfile.path)
    File.unlink(albumfile.path)
  end

  puts("Processing tracks")
  client.add_to_playlist_if_not_present(tracks_playlist, others_tracks)
  puts("Processing albums")
  client.add_to_playlist_if_not_present(albums_playlist, albums_tracks)
  File.write("#{ENV["HOME"]}/.local/share/spot-last-checked", YAML.dump(Date.today))
end

# Bulk follow artists from mpd, accessed using mpc.
# Asks you to edit a file with artist names to choose who to follow.
def bulk_follow_artists
  require "tempfile"

  client = SpotifyClient.new
  puts("Getting followed artists...")
  already_following = client.get_followed_artists
  puts("Found #{already_following.size}")

  puts("Getting artists from local library...")
  all_lines = `mpc listall -f '%albumartist%'`.lines(chomp: true).uniq.reject(&:empty?)
  puts("Found #{all_lines.size}")
  puts("Looking up artists on spotify...")
  artists = []
  total = all_lines.size
  print("Processing 0/#{total}")
  all_lines.each.with_index do |artist, i|
    print("\rProcessing #{i + 1}/#{total}: #{artist}")
    # TODO: in search, maybe look for an artist where I've already liked a song?
    response = client.api_call_get("search", {q: artist, type: :artist})
    found_artists = response["artists"]["items"]
    if found_artists.nil?
      warn("No artist found for #{artist}")
      next
    end

    found_artist = found_artists[0]
    if found_artist.nil?
      warn("No artist found for #{artist}")
    else
      found_artist["search_query"] = artist
      artists << found_artist unless artists.include?(found_artist)
    end
  end

  puts("Filtering already followed artists...")
  artists_to_follow_ignore = if File.exist?("#{ENV["HOME"]}/.local/share/spot-artists-follow-ignore")
    File.readlines("#{ENV["HOME"]}/.local/share/spot-artists-follow-ignore").map {
      _1.chomp.split("\t")
    }
  else
    []
  end

  artists_to_follow_without_followed_obj = artists
    .reject { |a| already_following.find { |af| af["uri"] == a["uri"] } }
  artists_to_follow_without_followed_arr = artists_to_follow_without_followed_obj
    .map { |a| [a["name"], a["external_urls"]["spotify"], a["search_query"]] }
  artists_to_follow = artists_to_follow_without_followed_arr - artists_to_follow_ignore

  tmpfile = Tempfile.new("artists_to_follow")
  begin
    tmpfile.write(
      artists_to_follow.map { _1.join("\t") }.join("\n")
    )
    tmpfile.close
    system(ENV["EDITOR"], tmpfile.path)
    tmpfile.open
    new_artists_to_follow = tmpfile
      .readlines(chomp: true)
      .reduce([]) do |res, chosen|
        name, href, _query = chosen.split("\t")
        res <<
          artists_to_follow_without_followed_obj.find { |a|
            a["name"] == name && a["external_urls"]["spotify"] == href
          }
      end
      .reject(&:empty?)

  ensure
    tmpfile.close
    tmpfile.unlink
  end

  to_subtract = new_artists_to_follow
    .map { |a| [a["name"], a["external_urls"]["spotify"], a["search_query"]] }

  to_add_to_ignore = (artists_to_follow - to_subtract)
  puts("Adding #{to_add_to_ignore.size} artists to ignore file")
  new_ignore = (artists_to_follow_ignore + to_add_to_ignore).uniq
  File.write("#{ENV["HOME"]}/.local/share/spot-artists-follow-ignore", new_ignore.map { _1.join("\t") }.join("\n"))

  new_artists_to_follow.each_slice(50) do |artists_by_50|
    ids = artists_by_50.map { _1["id"] }
    response = client.api_call_put("me/following", {ids: ids}, {type: :artist})
    puts(response)
  end
end
