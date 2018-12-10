class RemovePictureFromAuction < ActiveRecord::Migration[5.2]
  def change
    remove_column :auctions, :picture, :string
  end
end
