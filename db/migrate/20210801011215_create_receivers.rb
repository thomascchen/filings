class CreateReceivers < ActiveRecord::Migration[6.1]
  def change
    create_table :receivers do |t|
      t.string :ein, null: false, index: { unique: true }
      t.string :name, null: false

      t.timestamps
    end
  end
end
