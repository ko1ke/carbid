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
  belongs_to :user
  belongs_to :maker
  belongs_to :car

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

  scope :ongoing, -> { where(closed: false) }

  def close_at_must_be_future
    if close_at <= Time.now
      errors.add(:close_at, 'は現在以降の日時を設定してください')
    end
  end

  def car_must_have_relationship_with_maker
    return if (car_id.nil? || maker_id.nil?)
    car = Car.find_by(id: car_id)
    maker = Maker.find_by(id: maker_id)
    if car.maker != maker
      errors.add(:car_id, 'が選択したメーカーにはラインナップされていません。')
    end
  end
end
