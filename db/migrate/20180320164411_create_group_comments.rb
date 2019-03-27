class CreateGroupComments < ActiveRecord::Migration[5.1]
  def change
    create_table :group_comments do |t|
      t.integer :user_id
      t.integer :group_id
      t.text :content

      t.timestamps
    end
  end
end
