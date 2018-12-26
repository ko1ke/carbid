# == Schema Information
#
# Table name: cars
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  maker_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :car do
    sequence(:name) { |n| "car_#{n}" }
    maker
  end
end
