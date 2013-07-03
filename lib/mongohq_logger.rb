module MongohqLogger
  
  # def logme
    # collection_name = ActiveSupport::Inflector.pluralize(self.class.to_s.downcase)
    # begin
      # MongohqLogger.get_connection.collection(collection_name).save(JSON.parse(self.to_json))
    # rescue Exception=>e
      # puts "WARNING: MongoHQ is not logging."
    # end
  # end
  
  # def self.get_connection
    # return @@db_connection if @@db_connection
  # end
  
  # def self._connect
    # db = URI.parse(ENV['MONGOHQ_URL'])
    # db_name = db.path.gsub(/^\//, '')
    # @@db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    # @@db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  # end

end
