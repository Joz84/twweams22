class AddOtherColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :gender, :integer
    add_column :users, :bio, :text
    add_column :users, :book, :string
    add_column :users, :music, :string
    add_column :users, :movie, :string
    add_column :users, :birthday, :datetime
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
