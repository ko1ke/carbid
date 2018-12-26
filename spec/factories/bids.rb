# == Schema Information
#
# Table name: bids
#
#  id         :bigint(8)        not null, primary key
#  price      :integer
#  suggestion :text(65535)
#  image      :string(255)
#  user_id    :bigint(8)
#  auction_id :bigint(8)
#  accepted   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null


FactoryBot.define do
  factory :bid do
    user
    auction
    suggestion {'Awesome Suggestion'}
    price {9000}
  end
end