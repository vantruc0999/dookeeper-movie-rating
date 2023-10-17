class Movie < ApplicationRecord
    has_many :movie_genres, dependent: :destroy
    has_many :genres, through: :movie_genres
    has_many :ratings

    validates :title, presence: {messsage: "Movie title can not be blank"}, length: { in: 2..255, message: "Movie title must be between 2 and 255 characters long." }
    validates :director, presence: {messsage: "Movie director can not be blank"}, length: { in: 2..255, message: "Movie director must be between 2 and2 55 characters long." }
end
