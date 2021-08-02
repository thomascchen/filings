class DropAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_reference :filings, :filer_address, foreign_key: { to_table: :addresses }
    remove_reference :awards, :receiver_address, foreign_key: { to_table: :addresses }

    drop_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false

      t.timestamps
    end

    add_column :filers, :street, :string, null: false
    add_column :filers, :city, :string, null: false
    add_column :filers, :state, :string, null: false
    add_column :filers, :zip, :string, null: false

    add_column :receivers, :street, :string, null: false
    add_column :receivers, :city, :string, null: false
    add_column :receivers, :state, :string, null: false
    add_column :receivers, :zip, :string, null: false

    remove_index :filers, :ein, unique: true
    remove_index :receivers, :ein, unique: true
  end
end
