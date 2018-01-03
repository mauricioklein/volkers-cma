class User < ApplicationRecord
  validates_presence_of :full_name, :email, :password_digest
  validates :email, format: /\A(\S+)@(.+)\.(\S+)\z/, uniqueness: true
  validates :password_digest, length: { minimum: 8 }

  has_secure_password

  def as_json(options)
    super(only: [:id, :full_name, :email])
  end
end
