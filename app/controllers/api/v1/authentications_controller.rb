class Api::V1::AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        @token = Token.encode(user_id: @user.email)
        #render json: { token: @token, username: @user.username }, status: :ok
        @token, @user.username, @user.email
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end

    def set_default_request_format
      request.format = :json unless params[:format]
    end
end