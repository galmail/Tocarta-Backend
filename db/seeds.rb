if Rails.env.development?
  admin = User.create! :email => 'admin@tocarta.es', :password => 'qwerty', :password_confirmation => 'qwerty'
  admin.add_role :admin
  admin.save
end
