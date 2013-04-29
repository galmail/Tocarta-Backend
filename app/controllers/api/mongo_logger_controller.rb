require 'mongo'
require 'uri'
require 'json'

class Api::MongoLoggerController < ApplicationController

  def log_comment
    
  end

  private

  def get_connection
    return @db_connection if @db_connection
    db = URI.parse(ENV['MONGOHQ_URL'])
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    render :layout => false, :text => @db_connection.to_s
  end

end
