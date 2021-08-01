class AllowNullEinOnReceivers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :receivers, :ein, true
  end
end
