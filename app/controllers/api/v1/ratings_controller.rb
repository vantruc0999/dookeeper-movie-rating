class Api::V1::RatingsController < ApiController
    before_action :set_rating, only: %i[ show destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create destroy]

    include ApplicationHelper
    include ApiResponse
    # GET /ratings or /ratings.json
    def index
    end
  
    # GET /ratings/1 or /ratings/1.json
    def show
    end

    def create
      if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
        if Rating.find_by(user_id: current_user.id, movie_id: @movie.id)
            @error = "You can not review this movie again"
          else
            @rating = Rating.new(rating_params)
          end
      else
        @error = "That movie doesn't exist in our database yet!" if params[:movie_id]
      end
    
      if @error
        render_error(@error)
      else
        @rating.save
        render_success(@rating, "Rating created successfully")
      end
    end
    
    # DELETE /ratings/1 or /ratings/1.json
    def destroy
      @rating.destroy
      render_success(@rating, "Rating deleted successfully")
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rating
        @rating = Rating.find_by(id: params[:id])

        if !@rating
        render_error("rating not found")
        end
      end
  
      # Only allow a list of trusted parameters through.
      def rating_params
        params[:rating][:user_id] = current_user.id
        params.require(:rating).permit(:comment, :rating_value, :movie_id, :user_id)
      end
  end
  