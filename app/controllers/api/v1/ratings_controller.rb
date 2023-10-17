class Api::V1::RatingsController < ApiController
    before_action :set_rating, only: %i[ show destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
  
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
        render json: { error: @error }, status: :not_found
      else
        @rating.save
        render json: { 
          status: :ok,
          message: "Rating created successfully",
          data: @rating 
        }
      end
    end
    
    # DELETE /ratings/1 or /ratings/1.json
    def destroy
      @rating.destroy
      render json: { 
        status: :ok,
        message: "Rating deleted successfully",
        data: @rating 
      }
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rating
        @rating = Rating.find_by(id: params[:id])

        if !@rating
          render json: {
              status: :unprocessable_entity,
              message: "rating not found"
        }, status: :unprocessable_entity
        end
      end
  
      # Only allow a list of trusted parameters through.
      def rating_params
        params[:rating][:user_id] = current_user.id
        params.require(:rating).permit(:comment, :rating_value, :movie_id, :user_id)
      end
  end
  