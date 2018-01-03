FactoryBot.define do
  factory :contract do
    vendor "Vodafone"
    starts_on Date.yesterday
    ends_on Date.tomorrow
    price 29.99
    user
  end
end

# == Schema Information
# Schema version: 20180103080537
#
# Table name: contracts
#
#  id         :integer          not null, primary key
#  vendor     :string
#  starts_on  :date
#  ends_on    :date
#  price      :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contracts_on_user_id  (user_id)
#
