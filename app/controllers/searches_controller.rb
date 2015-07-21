class SearchesController < ApplicationController

  def new

  end

  def create
    @search = Search.new
    @haikus = @search.find_haikus(params[:mood], params[:search_term])
    respond_to do |format|
      format.js
    end
  end
end
