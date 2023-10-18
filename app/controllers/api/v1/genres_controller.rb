class Api::V1::GenresController < ApiController
    before_action :set_genre, only: %i[ show update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index show]
    before_action :is_admin?, only: %i[create update destroy]

    include ApplicationHelper
    include ApiResponse

    # GET /genres or /genres.json
    def index
      @genres = Genre.all
      render_success(@genres, 'Genres loaded successfully')
    end
  
    # GET /genres/1 or /genres/1.json
    def show
      render_success(@genre, 'Genre loaded successfully')
    end
  
    # POST /genres or /genres.json
    def create
        @genre = Genre.new(genre_params)

        if @genre.save
          render_success(@genre, "Genres created successfully")
        else    
          render_error(@genre.errors)
        end
    end
  
    # PATCH/PUT /genres/1 or /genres/1.json
    def update
        if @genre.update(genre_params)
          render_success(@genre, "Genre updated successfully")
        else    
          render_error(@genre.errors)
        end
    end
    # DELETE /genres/1 or /genres/1.json
    def destroy
        @genre.destroy
        render_success(@genre, "Genres deleted successfully")
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_genre
        @genre = Genre.find_by(id: params[:id])

        if !@genre
            render json: {
                status: :unprocessable_entity,
                message: "Genre not found"
          }, status: :unprocessable_entity
        end

      end
  
      # Only allow a list of trusted parameters through.
      def genre_params
        params.require(:genre).permit(:name, :description)
      end

      def get_current_user
        @current_user_doorkeeper = User.find(doorkeeper_token.resource_owner_id)
      end
end
  