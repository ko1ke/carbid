# == Schema Information
#
# Table name: makers
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Maker, type: :model do
  it 'should build factory' do
    expect(FactoryBot.build(:maker)).to be_valid
  end
end
