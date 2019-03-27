class CreateBiblePrayers < ActiveRecord::Migration[5.1]
  def change
    create_table :bible_prayers do |t|
      t.string :title
      t.string :verse
      t.text :summary
      t.text :scripture

      t.timestamps
    end
  end
end