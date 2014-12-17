class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :address
      t.decimal :weight

      t.timestamps
    end
  end
end
