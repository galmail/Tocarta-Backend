if Rails.env.development?
  puts "** Add roles"
  ENV['ROLES'].split(',').each do |r|
    Role.create! name: r.to_s
  end

  puts "** Add admin/qwerty"
  admin = User.create! :email => 'admin@tocarta.es', :password => 'qwerty', :password_confirmation => 'qwerty'
  admin.add_role :admin
  admin.save
  # User.update_all(:confirmed_at => Time.now)
end
