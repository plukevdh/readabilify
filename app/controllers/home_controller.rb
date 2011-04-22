class HomeController < ApplicationController
  def show
    return unless readabilified?

    @bookmarks =  Kaminari.paginate_array(
      readability(:bookmarks, {favorite: params[:favorite] || 0, 
                               archive: params[:archive] || 0})
      ).page(params[:page] || 1).per(15) 
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You have logged out of Readability."
  end
end
