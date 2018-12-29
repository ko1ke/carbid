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
#

class Bid < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :suggestion, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :new_price_must_be_lowest, on: :create
  validate :bidder_must_not_be_auction_master, on: :create
  validate :auction_must_be_open

  belongs_to :user
  belongs_to :auction

  scope :asc_price, -> {
    includes(:user).order(:price)
  }

  private

  def new_price_must_be_lowest
    return if price.nil?
    # where.notは画面から入力したレコードをはねるための処置
    min_price = auction.bids.where.not(id: nil).minimum(:price) || auction.initial_price
    if price >= min_price
      errors.add(:price, "は 「#{min_price}」より低い額を入力してください。")
    end
  end

  def bidder_must_not_be_auction_master
    bidder = user
    auction_master = auction.user
    if (bidder == auction_master)
      errors.add(:user, "は、自分のオークションには入札できません。")
    end
  end

  def auction_must_be_open
    if auction.closed?
      errors.add(:auction, "は、既に終了しているため、入札できません")
    end
  end
end
