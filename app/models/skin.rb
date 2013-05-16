# == Schema Information
#
# Table name: skins
#
#  id                      :integer          not null, primary key
#  theme_id                :integer
#  name                    :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  description             :text
#  stylesheet_file_name    :string(255)
#  stylesheet_content_type :string(255)
#  stylesheet_file_size    :integer
#  stylesheet_updated_at   :datetime
#  user_id                 :integer
#

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
