# == Schema Information
#
# Table name: roles
#
#  id                      :integer         not null, primary key
#  title                   :string(255)     indexed
#  view_books              :boolean         default(TRUE), not null
#  create_books            :boolean         default(FALSE), not null
#  edit_books              :boolean         default(FALSE), not null
#  delete_books            :boolean         default(FALSE), not null
#  manage_roles            :boolean         default(FALSE), not null

# Indexes
#  index_roles_on_title                  (title) UNIQUE

class Role < ActiveRecord::Base

  # ASSOCIATIONS
  has_and_belongs_to_many :users

  # VALIDATIONS
  validates :title, presence: true, format: {:with => /[\w ]+/i}, uniqueness: true, length: { in: 2..50 }

  # CONSTANTS
  ADMIN = "admin"
  STAFF = "staff"
  MEMBER = "member"

  def self.admin
    @admin_role ||= Role.where(title: ADMIN).first
  end

  def self.member
    @member_role ||= Role.where(title: MEMBER).first
  end
end