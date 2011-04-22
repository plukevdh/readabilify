module ArticlesHelper
  def format_link(article, format)
    link_to(format.to_s.upcase, article_path(article['article']['id'], format: format))
  end
end
