class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string, limit: 14
    add_column :users, :birth_date, :date
  end
end
