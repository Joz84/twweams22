class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :channel, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :last_message_id
      t.boolean :admin
      t.timestamps
    end
  end
end
