class ArticlesController < ApplicationController
  respond_to :pdf, :epub, :mobi

  def show
    article = readability :articles, {article: params[:id]}
    respond_with(article)
  end
end
