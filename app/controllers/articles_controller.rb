class ArticlesController < ApplicationController
  def show
    article = readability(:articles, {id: params[:id]}).to_options

    output = Bookit::Article.new({
      content: article[:content],
      author: article[:author] || "",
      date_published: (article[:date_published] ? Time.parse(article[:date_published]) : Time.now).strftime("%m/%d/%Y"),
      url: article[:url],
      title: article[:title]
    }, Bookit::Parser::Html)
    
    filename = output.title.downcase.split(' ')[0..4].each {|w| w.gsub!(/\W/, '')}.join('-')

    respond_to do |format|
      format.pdf  { send_data output.to_print(Bookit::Emitter::Pdf).render, filename: "#{filename}.pdf" }
      format.epub { send_data output.to_print(Bookit::Emitter::Epub).render, filename: "#{filename}.epub" }
      format.mobi { send_data output.to_print(Bookit::Emitter::Mobi).render, filename: "#{filename}.mobi" }
    end
  end
  
  def mass_convert
    files = []
    emitter = "Bookit::Emitter::#{params[:format].capitalize}".constantize
    user = readability(:users, {id: '_current'}).to_options[:username]

    params[:check].each do |aid|
      article = readability(:articles, {id: aid}).to_options

      output = Bookit::Article.new({
        content: article[:content],
        author: article[:author] || "",
        date_published: (article[:date_published] ? Time.parse(article[:date_published]) : Time.now).strftime("%m/%d/%Y"),
        url: article[:url],
        title: article[:title]
      }, Bookit::Parser::Html)

      filename = output.title.downcase.split(' ')[0..4].each {|w| w.gsub!(/\W/, '')}.join('-')
      files << output.to_print(emitter).save("tmp/docs/#{filename}.#{params[:format]}")
    end

    filename = "zips/#{user}-reading-list.zip"

    zip = Zip::Archive.open("public/#{filename}", Zip::CREATE) do |ar|
      files.each do |f|
        ar.add_file(f.path)
      end
    end
    
    render text: filename
  end
end
