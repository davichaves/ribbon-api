class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.integer :post_type
      t.string :media_url

      t.timestamps
    end
  end
end
