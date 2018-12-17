namespace :auction_task do
  desc 'Close auctions timed up and accept its cheapest bid'
  task close: :environment do
    Auction.must_be_closed.each do |auction|
      if auction.accept_and_close
        Rails.logger.info("オークション ID #{auction.id} を終了しました")
      else
        Rails.logger.error("オークション ID #{auction.id} の終了処理が失敗しました")
      end
    end
  end
end
