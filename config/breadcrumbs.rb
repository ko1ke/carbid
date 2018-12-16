crumb :auctions do
  link 'オークション一覧', root_path
end

crumb :bids do |auction|
  link "#{auction.title}の入札一覧", auction_bids_path(auction)
  parent :auctions
end

crumb :bid do |bid|
  link '入札'
  parent :bids, bid.auction
end

crumb :my_auctions do
  link 'マイオークション一覧', my_auctions_path
end

crumb :my_auction do |my_auction|
  link 'オークション', my_auction
  parent :my_auctions
end

crumb :my_bids do |my_auction|
  link "#{my_auction.title}の入札一覧", my_auction_bids_path(my_auction)
  parent :my_auctions
end

crumb :my_bid do |my_bid|
  link '購入'
  parent :my_bids, my_bid.auction
end

