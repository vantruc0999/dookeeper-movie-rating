class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :introduction
      t.string :story
      t.string :director
      t.date :release_date
      t.string :language
      t.string :poster

      t.timestamps
    end
  end
end
