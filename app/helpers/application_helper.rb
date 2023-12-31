module ApplicationHelper
    def is_admin?
        return if current_user&.admin?
        
        respond_to do |format|
            format.json { render json: { error: 'You are not authorized to access this page.' }, status: :unauthorized }
            # format.html { redirect_to root_path, notice: 'You are not authorized to access this page.' }
          end
    end

    def is_login?
        return if current_user
        
        respond_to do |format|
            format.json { render json: { status: 401, error: 'Unauthorized' }, status: :unauthorized }
            # format.html { redirect_to root_path, notice: 'You are not authorized to access this page.' }
          end
    end
end
