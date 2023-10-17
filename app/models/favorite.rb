class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    validates :movie_id, presence: true
end
