class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string  :title
      t.boolean :view_books, default: true, null: false
      t.boolean :create_books, default: false, null: false
      t.boolean :edit_books, default: false, null: false
      t.boolean :delete_books, default: false, null: false
      t.boolean :manage_roles, default: false, null: false
    end
    add_index :roles, :title, unique: true
  end


  def down
    drop_table :roles
  end
end
