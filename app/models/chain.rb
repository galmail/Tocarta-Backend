# == Schema Information
#
# Table name: chains
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  name                :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  logo_file_name      :string(255)
#  logo_content_type   :string(255)
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#  email               :string(255)
#  address             :string(255)
#  note                :text
#  i18nbg_file_name    :string(255)
#  i18nbg_content_type :string(255)
#  i18nbg_file_size    :integer
#  i18nbg_updated_at   :datetime
#  bg_file_name        :string(255)
#  bg_content_type     :string(255)
#  bg_file_size        :integer
#  bg_updated_at       :datetime
#

class Chain < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants
  has_many :wines
  has_many :dish_variation_sets
  has_many :agreements
  has_many :survey_questions
  has_attached_file(
    :logo,
    :default_url => '/default_images/chain_demo_logo.jpg',
    :path => "chain_:id/img/:style/chain_:id.:extension",
    :styles => { :medium => TocartaAdmin::Application::IMAGE_MEDIUM_SIZE }
  )
  has_attached_file(
    :i18nbg,
    :path => "chain_:id/img/chain_:id_i18nbg.:extension"
  )
  has_attached_file(
    :bg,
    :path => "chain_:id/img/chain_:id_bg.:extension"
  )

  attr_accessible :name, :email, :address, :note, :logo, :i18nbg, :bg, :user_id, :restaurant_ids

  attr_accessible :delete_bg
  attr_accessor   :delete_bg
  before_validation { self.bg.clear if self.delete_bg == '1' }

  #validates_attachment_presence :logo
  validates :user_id, :presence => true

end
