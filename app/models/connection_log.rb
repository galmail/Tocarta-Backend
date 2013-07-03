class ConnectionLog < ActiveRecord::Base
  attr_accessible :ip
  belongs_to :user

  def self.by_user(id)
    where(user_id: id)
  end

  # Clear old entries from table
  # @param user [User] user to clean
  # @param keep [Integer] entries to mantain
  def self.purge_by_user!(user, keep = 20)
    user_newest_logs = user.connection_logs.order("created_at DESC").limit(keep.to_i)
    date_to_mantain = user_newest_logs.last.created_at

    user.connection_logs.where("created_at < :date", {date: date_to_mantain}).destroy_all
  end
end
