require 'yaml'
require 'active_record/fixtures'
  
  # Creating Librarian
  email = User::ADMIN_EMAIL
  user = email.split("@").first
  puts "Creating role and user \'#{email}\'"
  if User::DEFAULT_PASSWORD.present?
    user = User.new(first_name: user.split("_").first, last_name: user.split("_").last, email: email, password: User::DEFAULT_PASSWORD, password_confirmation: User::DEFAULT_PASSWORD, contact_number: '123456')
  else
    user = User.new(first_name: user.split("_").first, last_name: user.split("_").last, email: email, password: 'rubyonrails', password_confirmation: 'rubyonrails', contact_number: '123698')
  end
  user.skip_confirmation!
  user.skip_confirmation_notification!
  user.save!
  user.roles = [Role.admin]
  user.role_id = Role.admin.id
  user.status = User::REGISTERED
  user.save
  puts "Role and user \'#{email}\' created"