class Api::V1::MoviesController < ApiController
    before_action :set_movie, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
  
    # GET /movies or /movies.json
    def index
        @movies = Movie.includes(:genres).all
        render json:{
            status: 'Success',
            message: "Movies load successfully",
            data: @movies.as_json(include: { genres: { except: [:created_at, :updated_at] } }),
        }, status: :ok
    end
  
    # GET /movies/1 or /movies/1.json
    def show
        render json: {
            status: 200,
            data: @movie.as_json(include: { genres: { except: [:created_at, :updated_at] } }),
      }, status: :ok
    end
  
    # POST /movies or /movies.json
    def create
        @movie = Movie.new(movie_params)
      
        if @movie.save
          params[:genres].each do |genre_id|
            genre = Genre.find_or_create_by(id: genre_id)
            @movie.genres << genre
          end
      
          render json: {
            status: :ok,
            message: "Movie created successfully",
            data: @movie
          }, status: :ok
        else
          render json: {
            status: :unprocessable_entity,
            message: @movie.errors
          }, status: :unprocessable_entity
        end
      end
      
  
    # PATCH/PUT /movies/1 or /movies/1.json
    def update      
        if @movie.update(movie_params)
          # Clear existing associations
          @movie.genres.clear
      
          params[:genres].each do |genre_id|
            genre = Genre.find_or_create_by(id: genre_id)
            @movie.genres << genre
          end
      
          render json: {
            status: :ok,
            message: "Movie updated successfully",
            data: @movie
          }, status: :ok
        else
          render json: {
            status: :unprocessable_entity,
            message: @movie.errors
          }, status: :unprocessable_entity
        end
      end
      
  
    # DELETE /movies/1 or /movies/1.json
    def destroy
        @movie.destroy
        render json: {
          status: :ok,
          message: "Movie deleted successfully",
        }, status: :ok
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_movie
        @movie = Movie.find_by(id: params[:id])

        if !@movie
            render json: {
                status: :unprocessable_entity,
                message: "Movie not found"
        }, status: :unprocessable_entity
        end
      end
  
      # Only allow a list of trusted parameters through.
      def movie_params
        params.require(:movie).permit(:title, :director, :release_date, :language, :story, :poster, :introduction, :genres)
      end
  end
  