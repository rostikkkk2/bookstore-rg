class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text_comment
      t.integer :rating
      t.boolean :is_verified, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
