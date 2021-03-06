class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.timestamps
      t.references :profile, null: false, foreign_key: true
      t.string :text, null: false
      t.datetime :published_at, null: false
    end
  end
end
