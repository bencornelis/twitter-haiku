class Search
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
  end

  def find_haikus(mood, topic)
    results = client.search("#haiku #{mood} #{topic} -rt", result_type: "mixed").take(5)
    if results.empty?
      results = client.search("#haiku #{topic} -rt", result_type: "mixed").take(5)
    end
    results.sort_by { |haiku| -(haiku.favorite_count + haiku.retweet_count) }
  end

  def find_other_haikus(screen_name)
    client.user_timeline(screen_name).select {|tweet| tweet.hashtags.any?}
                                     .select {|tweet| tweet.hashtags.map {|hashtag|
                                              hashtag.text}.include?('Haiku') }
  end

  def haiku_count(screen_name)
    find_other_haikus(screen_name).length
  end

end
