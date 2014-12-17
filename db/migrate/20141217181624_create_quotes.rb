class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :provider
      t.text :estimate

      t.timestamps
    end
  end
end
