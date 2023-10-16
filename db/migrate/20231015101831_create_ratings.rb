class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|

      t.float :rating_value
      t.string :comment

      t.timestamps
    end
  end
end
