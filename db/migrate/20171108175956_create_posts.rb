class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :owner
      t.string :title
      t.string :body
      t.string :coordinate
      t.boolean :private

      t.timestamps
    end
  end
end
