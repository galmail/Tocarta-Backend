class Skin < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  has_many :menus
  
  has_attached_file(
   :stylesheet,
   :path => "skins/style_:id.css"
  )
  
  attr_accessible :name, :description, :stylesheet, :theme_id, :user_id
  validates_attachment_presence :stylesheet
  validates :name, :theme_id, :user_id, :presence => true
  
end
