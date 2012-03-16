require 'cgi'

class TwitterController < ApplicationController
  before_filter :setup_client
  
  def login
    resp = {:request_token => '', :request_secret => '', :authorize_url => ''}
    request_token = @client.request_token(:oauth_callback => ENV['twitter_callback_url'])
    resp[:request_token] = request_token.token
    resp[:request_secret] = request_token.secret
    resp[:authorize_url] = request_token.authorize_url
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
    
  def authorize_redirect
    request_token = {
      :token => CGI.unescape(params[:request_token]),
      :secret => CGI.unescape(params[:request_secret]),
      :authorize_url => CGI.unescape(params[:authorize_url])
    }
    response.redirect request_token[:authorize_url].gsub('authorize', 'authenticate')
    render :nothing => true
  end
  
=begin
  def oauth_redirect
    resp = {:oauth_token => params[:oauth_token], :oauth_verifier => params[:oauth_verifier]}
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
=end
    
  def authorize_verify
    resp = {:access_token => '', :access_secret => ''}
    begin
      @access_token = @client.authorize(
        CGI.unescape(params[:request_token]),
        CGI.unescape(params[:request_secret]),
        :oauth_verifier => CGI.unescape(params[:oauth_verifier])
      )
    rescue OAuth::Unauthorized
      puts "unauthorized"
    end

    if @client.authorized?
      resp[:access_token] = @access_token.token
      resp[:access_secret] = @access_token.secret
    end
    
    respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end
  
  def tweet
    resp = {:updated => false}
    if @client.authorized?
        @client.update(params[:msg])
        resp[:updated] = true
      end
      respond_to do |format|
      format.xml  { render :xml => resp.to_xml }
      format.json  { render :json => resp.to_json }
    end
  end

  private

  def setup_client
    @client = TwitterOAuth::Client.new(
      :consumer_key => ENV['twitter_key'],
      :consumer_secret => ENV['twitter_secret'],
      :token => params[:access_token],
      :secret => params[:access_secret]
    )
  end

end
