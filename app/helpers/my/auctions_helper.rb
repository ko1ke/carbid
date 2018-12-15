module My::AuctionsHelper
  def mention_status(closed)
    closed ? '終了' : '開催中'
  end
end
