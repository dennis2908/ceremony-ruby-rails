class CreatePrayers < ActiveRecord::Migration[5.1]
  def change
    create_table :prayers do |t|
      t.text :details
      t.string :overview
      t.integer :author_id
      t.boolean :anonymous?, default: false
      t.boolean :public?, default: false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
