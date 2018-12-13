class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :price
      t.text :suggestion
      t.string :image
      t.references :user, foreign_key: true
      t.references :auction, foreign_key: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
