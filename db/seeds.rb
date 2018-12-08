# Use commend 'rails db:setup' when setting

makers = %w(T社 H社 M社 B社 S社)
makers.each do |maker|
  Maker.create!(name: maker)
end

puts '5 Makers created'

5.times.each do |n|
  User.create!(email: "test_#{n}@test.com", password: 'password', password_confirmation:'password', tel:'0000000000', name: "test_#{n}")
end

puts '5 Users created'

5.times.each do |n|
  Auction.create!(maker: Maker.first, user: User.first, close_at: DateTime.now + 1.day, closed:false, title: "auction_#{n}", description: "An auction #{n}", initial_price: 10000)
end

puts '5 auctions created'