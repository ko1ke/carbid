class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.references :user, foreign_key: true
      t.datetime :close_at, null:false
      t.boolean :closed, default: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :picture
      t.integer :initial_price, default: 0
      t.references :maker, foreign_key: true

      t.timestamps
    end
  end
end
