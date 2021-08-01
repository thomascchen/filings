class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.integer :cash_amount, null: false
      t.string :purpose, null: false
      t.references :filer
      t.references :filing
      t.references :receiver
      t.references :receiver_address, foreign_key: { to_table: :addresses }

      t.timestamps
    end
  end
end
