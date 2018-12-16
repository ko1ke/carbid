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

class Auction < ApplicationRecord
  is_impressionable

  belongs_to :user
  belongs_to :maker
  belongs_to :car
  delegate :cars, to: :maker

  has_many :bids, dependent: :destroy
  # オークションにビッドしたユーザー（注：重複しうる）
  has_many :bidders, through: :bids, source: :user

  validates :close_at, presence: true
  validates :user_id, presence: true
  validates :maker_id, presence: true
  validates :car_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :close_at, presence: true
  validates :initial_price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :close_at_must_be_future
  validate :car_must_have_relationship_with_maker
  validate :size_limit_ongoing_auctions

  scope :ongoing, -> { where(closed: false) }

  def min_price
    if bidden?
      bids.minimum(:price)
    else
      initial_price
    end
  end

  def bidden?
    bidders.exists?
  end

  private

  def close_at_must_be_future
    if close_at <= Time.now
      errors.add(:close_at, 'は現在以降の日時を設定してください')
    end
  end

  def car_must_have_relationship_with_maker
    return if car_id.nil?
    car = Car.find_by(id: car_id)
    unless cars.include?(car)
      errors.add(:car_id, 'が選択したメーカーにはラインナップされていません。')
    end
  end

  def size_limit_ongoing_auctions
    limit_size = 3
    if user.owning_auctions.where(closed: false).size >= limit_size
      errors.add(:user_id, "1人につき開催できるオークションは最大#{limit_size}つまでです。")
    end
  end
end
