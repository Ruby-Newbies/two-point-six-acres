class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, except: :login


    def login
      @user = User.find_by_email(params[:email])
      puts "password=#{params[:password]}"
      puts "@user.password_digest=#{@user.password_digest}"
      if @user.password_digest == params[:password]
        puts "password matched"
        @token = Token.encode(user_id: @user.email)
        render json: { token: @token, username: @user.username }, status: :ok
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