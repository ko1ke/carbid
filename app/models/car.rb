# == Schema Information
#
# Table name: cars
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  maker_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Car < ApplicationRecord
  belongs_to :maker, inverse_of: :cars
  validates :name, presence: true
end
