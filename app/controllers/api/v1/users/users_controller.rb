class Api::V1::Users::UsersController < ApiController
    before_action :set_user, only: %i[ get_user update_user]
    skip_before_action :doorkeeper_authorize!
    before_action :is_login?, only: %i[ get_user get_all_users update_user]
    before_action :is_admin?, only: %i[ get_all_users add_user]

    include ApplicationHelper
    include ApiResponse
    include DoorkeeperRegisterable

    def get_user
        render_success(@user, 'User load successfully')
    end

    def get_all_users
        render_success(User.all, 'Users load successfully')
    end

    def update_user
        allowed_params = user_params.except(:client_id, :email, :password)

        if @user.update(allowed_params)
            render_success(@user, 'User information updated successfully')
        else
            render_error(@user.errors)
        end
    end

    def add_user
        client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])
            unless client_app
                return render json: 
                {
                    error: I18n.t('doorkeeper.errors.messages.invalid_client')
                }, status: :unauthorized
            end

        allowed_params = user_params.except(:client_id)
        user = User.new(allowed_params)

        if user.save 
            render json: render_user(user, client_app), status: :ok
        else
            render json: {errors: user.errors}, status: :unprocessable_entity
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = current_user
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.permit(:name, :phone, :birth_date, :email, :password, :client_id)
      end
end
