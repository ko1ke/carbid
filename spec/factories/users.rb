# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tel                    :string(255)      not null
#  name                   :string(255)      not null
#  avatar                 :string(255)
#

FactoryBot.define do

  factory :user do
    sequence(:name) { |n| "TEST_NAME_#{n}" }
    password {'passoword'}
    sequence(:email) {|n| "test_#{n}@test.com"}
    tel {'00000000000'}

    trait :no_tel do
      tel {''}
    end
  end
end
