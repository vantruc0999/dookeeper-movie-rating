module ApiResponse
  extend ActiveSupport::Concern

  def render_success(data, message, status = :ok)
    render json: {
      status: 'Success',
      message: message,
      data: data
    }, status: status
  end

  def render_error(errors, status = :unprocessable_entity)
    render json: {
      status: 'Error',
      message: errors
    }, status: status
  end
end
