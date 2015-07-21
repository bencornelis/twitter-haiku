class UserSearch
  include TwitterClient
  attr_reader :screen_name, :user

  def initialize(user_id)
    @user = CLIENT.user(user_id.to_i)
    @screen_name = user.screen_name
  end

  def haikus
    @haikus ||= CLIENT.user_timeline(screen_name)
                  .select {|tweet| tweet.hashtags.any?}
                  .select {|tweet|
                    hashtags = tweet.hashtags.map {|hashtag| hashtag.text}
                    hashtags.include?('Haiku') || hashtags.include?('haiku') }
                  .map { |tweet| Haiku.new(tweet) }
  end

  def haiku_count
    haikus.length
  end
end
