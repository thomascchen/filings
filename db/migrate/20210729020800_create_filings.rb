class CreateFilings < ActiveRecord::Migration[6.1]
  def change
    create_table :filings do |t|
      t.string :url
      t.xml :data

      t.timestamps
    end
  end
end
