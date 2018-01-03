class User < ApplicationRecord
  validates_presence_of :full_name, :email, :password_digest
  validates :email, format: /\A(\S+)@(.+)\.(\S+)\z/, uniqueness: true
  validates :password_digest, length: { minimum: 8 }

  has_secure_password

  def as_json(options)
    super(only: [:id, :full_name, :email])
  end
end

# == Schema Information
# Schema version: 20180103080537
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string
#
# Indexes
#
#  index_users_on_token  (token)
#
