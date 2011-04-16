class HomeController < ApplicationController
  before_filter :parse_options, only: [:show]

  def show
    return unless access_token
    data = JSON.parse @access_token.get("#{API_PATH}/bookmarks#{@options}").body

    @titles = data['bookmarks'].map {|x| x['article']['title']}
  end

  def register
    @request_token = API.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = @request_token
    redirect_to @request_token.authorize_url(:oauth_callback => callback_url)
  end

  private 
  def access_token
    session[:verifier] ||= params[:oauth_verifier]

    return nil unless session[:request_token] && session[:verifier]
    @access_token ||= session[:request_token].get_access_token(:oauth_verifier => session[:verifier])
  end

  def parse_options
    @options = "?"
    @options += "archive=#{params[:show_archived] || 0}"
  end

  def callback_url
    uri = URI.parse(request.url)
    uri.path = home_path
    uri.query = nil
    uri.to_s
  end

end
