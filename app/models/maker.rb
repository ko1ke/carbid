# == Schema Information
#
# Table name: makers
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Maker < ApplicationRecord
  has_many :cars, inverse_of: :maker
  validates :name, presence: true, uniqueness: true
end
