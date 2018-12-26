# == Schema Information
#
# Table name: auctions
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)
#  close_at      :datetime         not null
#  closed        :boolean          default(FALSE)
#  title         :string(255)      not null
#  description   :text(65535)      not null
#  initial_price :integer          default(0)
#  maker_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  car_id        :bigint(8)
#
#
FactoryBot.define do
  factory :auction do
    user
    car
    maker_id {car.maker.id}
    title { |n| "AUCTION_#{n}" }
    description {'Awesome Auction'}
    initial_price {10000}
    close_at {DateTime.now + 1.week}
  end
end

