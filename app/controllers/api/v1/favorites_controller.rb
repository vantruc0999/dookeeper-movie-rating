class Api::V1::FavoritesController < ApiController
    before_action :set_favorite, only: %i[ show ]
    skip_before_action :doorkeeper_authorize!, only: %i[show]
    before_action :is_admin?, only: %i[create]

    include ApplicationHelper
    include ApiResponse
    
    # GET /favorites or /favorites.json
    def index
        @favorites = Favorite.where(user_id: current_user.id).includes(:movie)

        data = @favorites.map do |item|
        {
            favorite_id: item.id,
            movie: item.movie.as_json
            # movie: item.movie.attributes.except('created_at', 'updated_at')
        }
        end

        render_success(data,'Movies favorites loaded successfully')
    end
  
    # GET /favorites/1 or /favorites/1.json
    def show
    end
  
    # POST /favorites or /favorites.json
    def create
        @movie = Movie.find_by_id(params[:movie_id])
        if @movie.nil?
          return render_error("That movie doesn't exist in our database yet!")
        end
      
        @favorite = Favorite.find_by(user_id: current_user.id, movie_id: @movie.id)
      
        if @favorite
          @favorite.destroy
          render_success( @favorite,"Movie has been removed from favorites successfully")
        else
          @favorite = Favorite.new(favorite_params)
      
          if @favorite.save
            render_success(@favorite, "Movie has been added to favorites successfully")
          else
            render_error(@favorite.errors.full_messages.join(', '), :unprocessable_entity)
          end
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_favorite
        @favorite = Favorite.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def favorite_params
        params[:favorite][:user_id] = current_user.id
        params.require(:favorite).permit(:movie_id, :user_id)
      end
      
  end
  