class User < ApplicationRecord
  validates_presence_of :full_name, :email, :password
  validates :email, format: /\A(\S+)@(.+)\.(\S+)\z/
  validates :password, length: { minimum: 8 }
end
