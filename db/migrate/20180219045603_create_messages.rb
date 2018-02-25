class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :sender
      t.string :receiver
      t.string :content
      t.string :convo_id
      t.timestamps
    end
  end
end
