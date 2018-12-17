# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tel                    :string(255)      not null
#  name                   :string(255)      not null
#  avatar                 :string(255)
#

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids

  # 自分が作成したオークション
  has_many :owning_auctions, -> {includes(:maker, :car)}, class_name: 'Auction', dependent: :destroy
  # 自分がビットしたオークション。自分のオークションにビッドは不可。
  has_many :bidden_auctions, through: :bids, source: :auction

  validates :name, presence: true
  validates :tel, presence: true

  validate :tel_must_be_number

  private

  def tel_must_be_number
    return if tel.empty?
    unless tel.match(/\A\d+\z/)
      errors.add(:tel, 'は数字のみで入力してください。')
    end
  end
end
