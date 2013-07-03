# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  scopify
  
  # Clean roles list to use in public views
  def self.roles_clean
    ENV['ROLES'] - ['admin']
  end

  # Return a role given a param code
  def self.code_to_role(r)
    return 'restaurant'  if r == 'r'
    return 'distributor' if r == 'd'
    return 'user'
  end
end
