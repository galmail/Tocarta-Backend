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
  attr_accessible :rol, :locale, :revision, :title, :description, :content

  scope :list, select([:rol, :content])
end
