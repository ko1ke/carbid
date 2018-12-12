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

require 'rails_helper'

RSpec.describe Car, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
