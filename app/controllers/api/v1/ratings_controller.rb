class Api::V1::RatingsController < ApiController
    before_action :set_rating, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
  
    # GET /ratings or /ratings.json
    def index
      @ratings = Rating.all
    end
  
    # GET /ratings/1 or /ratings/1.json
    def show
    end

    def create
      if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
        if Rating.find_by(user_id: get_doorkeeper_user.id, movie_id: @movie.id)
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
          rating: @rating 
        }
      end
    end
    
    # PATCH/PUT /ratings/1 or /ratings/1.json
    def update
     
    end
  
    # DELETE /ratings/1 or /ratings/1.json
    def destroy
     
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rating
        @rating = Rating.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def rating_params
        user = User.find(doorkeeper_token.resource_owner_id)
        params[:rating][:user_id] = user.id
        params.require(:rating).permit(:comment, :rating_value, :movie_id, :user_id)
      end

      def get_doorkeeper_user
        @current_user_doorkeeper = User.find(doorkeeper_token.resource_owner_id)
      end
  end
  