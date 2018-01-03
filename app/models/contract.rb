class Contract < ApplicationRecord
  belongs_to :user

  validates_presence_of :vendor, :starts_on, :ends_on, :price, :user
  validate :starts_on_before_ends_on
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates_associated :user

private

  def starts_on_before_ends_on
    return unless starts_on.present? && ends_on.present?

    timestamp = ->(date) { date.to_time.to_i }
    errors.add(:starts_on, "must be before than ends_on") if timestamp.(starts_on) > timestamp.(ends_on)
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
