class CreateGenreMovie < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_genres do |t|
      t.belongs_to :genre, null: false, foreign_key: true
      t.belongs_to :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
