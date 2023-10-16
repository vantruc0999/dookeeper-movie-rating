class Api::V1::GenresController < ApiController
    before_action :set_genre, only: %i[ show edit update destroy ]
    skip_before_action :doorkeeper_authorize!, only: %i[index]

    # GET /genres or /genres.json
    def index
      @genres = Genre.all
      respond_to do |format|
        format.json {render json: @genres}
      end
    end
  
    # GET /genres/1 or /genres/1.json
    def show
    end
  
    # GET /genres/new
    def new
      @genre = Genre.new
    end
  
    # GET /genres/1/edit
    def edit
    end
  
    # POST /genres or /genres.json
    def create
      @genre = Genre.new(genre_params)
  
      respond_to do |format|
        if @genre.save
          render json: {
                status: :ok,
                message: "Genres created successfully",
                data: @genre
          }
        else
            render json: {
                status: :unprocessable_entity,
                message:  @genre.errors,
                data: @genre
          }
        end
      end
    end
  
    # PATCH/PUT /genres/1 or /genres/1.json
    def update
      respond_to do |format|
        if @genre.update(genre_params)
          format.html { redirect_to genre_url(@genre), notice: "Genre was successfully updated." }
          format.json { render :show, status: :ok, location: @genre }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @genre.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /genres/1 or /genres/1.json
    def destroy
      @genre.destroy!
  
      respond_to do |format|
        format.html { redirect_to genres_url, notice: "Genre was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_genre
        @genre = Genre.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def genre_params
        params.require(:genre).permit(:name, :description)
      end
end
  