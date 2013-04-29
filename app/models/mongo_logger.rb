# require 'mongo'
# require 'uri'
# require 'json'

class MongoLogger < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def log(object)
    db = get_connection
    # TODO log the object as a json
  end
  
  private
  
  def get_connection
    return @db_connection if @db_connection
    db = URI.parse(ENV['MONGOHQ_URL'])
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  end
  
  
end
