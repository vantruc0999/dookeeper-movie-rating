class RemovePosterFromMovie < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :poster, :string
  end
end
