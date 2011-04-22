class HomeController < ApplicationController
  readabilify

  def show
    @bookmarks = readability :bookmarks, {favorite: params[:favorite] || 0, 
                                         archive: params[:archive] || 0} if readabilified?
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You have logged out of Readability."
  end
end
