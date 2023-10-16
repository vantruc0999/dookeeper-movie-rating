class Api::V1::Android::BooksController < ApiController
    before_action :set_book, only: %i[ show ]
    skip_before_action :doorkeeper_authorize!
    before_action :is_admin?

    include ApplicationHelper
    # GET /books or /books.json
    def index
      @books = Book.all
      respond_to do |format|
        format.any {redirect_to root_url}
        format.json {render json: @books}
      end
    end
  
    # GET /books/1 or /books/1.json
    def show
        render json: @book
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book)
      end
  end
  