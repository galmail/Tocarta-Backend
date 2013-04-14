if Rails.env.development?
  admin = User.create! :email => 'user@tocarta.es', :password => 'qwerty', :password_confirmation => 'qwerty'
  admin.role = 'admin'
  admin.save
end
