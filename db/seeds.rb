# Use commend 'rails db:setup' when setting

maker_names = %w(Tiyoda Hinoda Matsuya Bingo Solidus)
maker_names.each do |maker|
  Maker.create!(name: maker)
end

puts '5 Makers created'

car_names = %w(basic custom racing)
Maker.all.each do |maker|
  car_names.each do |car_name|
    Car.create!(name: "#{maker.name}-#{car_name}", maker: maker)
  end
end

puts '3 cars for each maker created'

5.times.each do |n|
  User.create!(email: "test_#{n}@test.com", password: 'password', password_confirmation:'password', tel:'0000000000', name: "test_#{n}")
end

puts '5 Users created'

5.times.each do |n|
  Auction.create!(maker: Maker.first, user: User.first, car: Car.first, close_at: DateTime.now + 1.day, closed:false, title: "auction_#{n}", description: "An auction #{n}, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", initial_price: 10000)
end

puts '5 auctions created'

5.times.each do |n|
  Bid.create!(auction: Auction.first, user: User.last, price: 1000 + n * 1000, image: 'no_image.png', suggestion: 'Excellent car for you!')
end
