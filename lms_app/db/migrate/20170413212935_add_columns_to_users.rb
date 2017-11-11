class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :about_me, :text
    add_column :users, :contact_number, :string, null: false
    add_column :users, :gender, :string
    add_column :users, :role_id, :integer
    add_column :users, :location, :string
    add_column :users, :interests, :text
    add_column :users, :status, :integer

    add_index :users, :role_id
    add_index :users, :status
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :about_me
    remove_column :users, :contact_number
    remove_column :users, :gender
    remove_column :users, :role_id
    remove_column :users, :location
    remove_column :users, :interests
    remove_column :users, :status

    remove_index :users, :role_id
    remove_index :users, :status
  end   
end
