class Agreement < ActiveRecord::Base
  attr_accessible :rol, :locale, :revision, :title, :description, :content
end
