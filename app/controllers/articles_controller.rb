class ArticlesController < ApplicationController
  def show
    article = readability :articles, {id: params[:id]}

    output = Bookit::Article.new article

    respond_to do |format|
      format.pdf { send_file article.to_pdf }
    end
  end
end
