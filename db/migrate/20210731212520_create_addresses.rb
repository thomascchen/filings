class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false

      t.timestamps
    end

    remove_column :filers, :address, :string
    remove_column :filers, :city, :string
    remove_column :filers, :state, :string
    remove_column :filers, :zip, :string

    add_reference :filings, :filer
    add_reference :filings, :filer_address, foreign_key: { to_table: :addresses }

    change_column_null :filings, :url, false
    rename_column :filings, :data, :xml
    change_column_null :filings, :xml, false
        
    change_column_null :filers, :ein, false
    change_column_null :filers, :name, false
  end
end
