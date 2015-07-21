class Haiku
  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def author
    tweet.user
  end

  def author_name
    author.screen_name
  end

  def text
    tweet.text
  end

  def retweets
    tweet.retweet_count
  end

  def favorites
    tweet.favorite_count
  end
end
