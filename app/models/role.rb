class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  scopify
  
  # Clean roles list to use in public views
  def self.roles_clean
    Application['roles'] - ['admin']
  end
end
