class UserSearchesController < ApplicationController
  def create
    @search = UserSearch.new(params[:author_id])
    respond_to do |format|
      format.html {
        @haikus = @search.haikus
        render :show
      }
      format.js
    end
  end

end
