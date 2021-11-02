class Api::V1::ApplicationController < Api::V1::BaseController

    def not_found
      render json: { error: 'not_found' }
    end
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = Token.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => exception
        render json: { errors: exception.message }, status: :unauthorized
      rescue JWT::DecodeError => exception
        render json: { errors: exception.message }, status: :unauthorized
      end
    end

    def set_default_request_format
        request.format = :json unless params[:format]
    end
  end