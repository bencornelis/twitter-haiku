class HaikuSearch < Search
  attr_reader :mood, :topic

  def initialize(attr)
    @mood = attr[:mood]
    @topic = attr[:topic]
  end

  def find_haikus
    results = CLIENT.search("#haiku #{mood} #{topic} -rt", result_type: "mixed").take(20)
    if results.empty?
      results = CLIENT.search("#haiku #{topic} -rt", result_type: "mixed").take(20)
    end
    results.map { |tweet|
      Haiku.new(tweet) }
           .uniq { |haiku| haiku.author.id }
           .sort_by { |haiku|
              -(haiku.favorites + haiku.retweets) }
  end
end
