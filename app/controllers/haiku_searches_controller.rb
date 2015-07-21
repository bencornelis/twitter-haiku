class HaikuSearchesController < ApplicationController

  def new

  end

  def create
    @search = HaikuSearch.new(search_params)
    @haikus = @search.find_haikus
    respond_to do |format|
      format.js
    end
  end

  private
  def search_params
    params.permit(:mood, :topic)
  end
end
