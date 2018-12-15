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

  belongs_to :user
  belongs_to :auction

  def new_price_must_be_lowest
    return if price.nil?
    # where.notは画面から入力したレコードをはねるための処置
    min_price = auction.bids.where.not(id: nil).minimum(:price) || auction.initial_price
    if price >= min_price
      errors.add(:price, "は 「#{min_price}」より低い額を入力してください。")
    end
  end
end
