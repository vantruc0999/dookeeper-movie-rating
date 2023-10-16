class Genre < ApplicationRecord
    has_many :movie_genres
    has_many :movies, through: :movie_genres

    validates :name, presence: {messsage: "Genre name can not be blank"}, length: { in: 2..255, message: "Genre name must be between 2 and 50 characters long." }, uniqueness: { message: "Genre name is already taken." }
    validates :description, length: { maximum: 255, message: "Description can't be longer than 255 characters." }
  end
  