# == Schema Information
#
# Table name: agreements
#
#  id          :integer          not null, primary key
#  rol         :string(255)
#  locale      :string(255)
#  revision    :integer
#  title       :string(255)
#  description :string(255)
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Agreement < ActiveRecord::Base
  belongs_to  :chain
  attr_accessible :rol, :locale, :revision, :title, :description, :content, :legal_type, :chain_id
  scope :list, select([:rol, :content, :title])
  
  def legal_type_enum
    ['share_policy','opinate_policy','terms_of_use','privacy_policy']
  end
  
end
