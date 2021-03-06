class ApplicationController < ActionController::Base
  if Rails.env.production?
    rescue_from StandardError, with: :rescue_internal_error
    rescue_from ActionController::RoutingError, with: :rescue_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::UnknownFormat, with: :rescue_not_found
    rescue_from ActionView::MissingTemplate, with: :rescue_not_found
  end

  def rescue_not_found(error = nil)
    Rails.logger.warn(
      "message: 404 NotFound #{request.url},
      #{error&.message},
      #{error&.class}"
    )
    render json: { message: "not found", status: 404 }
  end

  def rescue_internal_error(error = nil)
    Rails.logger.error(
      "message: 500 InternalError #{request.url},
      #{error&.message},
      #{error&.class}"
    )
    render json: { message: "internal error", status: 500 }
  end
end
