FactoryBot.define do
  factory :contract do
    vendor "Vodafone"
    starts_on Date.yesterday
    ends_on Date.tomorrow
    price 29.99
    active true
    user
  end
end

# == Schema Information
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
#  active     :boolean
#
# Indexes
#
#  index_contracts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
