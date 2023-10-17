class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    validates :comment, :rating_value, :user_id, :movie_id, presence: true
end
