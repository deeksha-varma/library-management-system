# == Schema Information
#
# Table name: users
#
#  id                         :integer         not null, primary key
#  email                      :string(255)     default(""), not null, indexed
#  encrypted_password         :string(128)     default(""), not null
#  first_name                 :string(255)
#  last_name                  :string(255)
#  about_me                   :text
#  contact_number             :string(255)
#  location                   :string(255)
#  gender                     :string(255)
#  role_id                    :integer         indexed
#  status                     :integer         indexed
#  reset_password_token       :string(255)     indexed
#  remember_token             :string(255)
#  remember_created_at        :datetime
#  sign_in_count              :integer         default(0)
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :string(255)
#  last_sign_in_ip            :string(255)
#  confirmation_token         :string(255)     indexed
#  confirmed_at               :datetime
#  confirmation_sent_at       :datetime
#  locked_at                  :datetime
#  authentication_token       :string(255)
#  created_at                 :datetime        not null
#  updated_at                 :datetime        not null

#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_status                (status)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # ASSOCIATIONS
  has_and_belongs_to_many :roles

  after_commit :assign_role_member, on: :create

  # CONSTANTS
  ADMIN_EMAIL = "library_admin@ReportBee.net"
  DEFAULT_PASSWORD = "reportbee"
  REGISTERED = 1  

  # Public: Assigns role for user
  # all users created will be assigned the default member role
  #
  # Return value not used
  def assign_role_member
    self.roles << [Role.send(:member)]
  end

  def is_admin_user?
    self.roles.pluck(:id).include?(Role.admin.id)
  end

  def member?
    self.roles.pluck(:id).include?(Role.member.id)
  end
end
