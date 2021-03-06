class Api::V1::AuthenticationController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request, except: [:login, :adminlogin]


  def login
    if login_params[:email].empty? || login_params[:password].empty?
     render json: { error: 'missing input' }, status: :unauthorized
     return
    end
    @user = User.find_by_email(login_params[:email])
    if @user.nil?
      puts "user with email #{login_params[:email]} not found"
      render json: { error: 'wrong email' }, status: :unauthorized
      return
    end

    # if @user.authenticate(login_params[:password])
    if @user.password_digest == login_params[:password]
      puts "password matched"
      time = Time.now + 72.hours.to_i
      @token = Token.encode(email: @user.email)
      render json: { token: @token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username, id: @user.id }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def adminlogin
    if login_params[:email].empty? || login_params[:password].empty?
     render json: { error: 'missing input' }, status: :unauthorized
     return
    end
    @user = User.find_by_email(login_params[:email])
    if @user.nil?
      puts "user with email #{login_params[:email]} not found"
      render json: { error: 'wrong email' }, status: :unauthorized
      return
    end
    if @user.role != 'admin'
      render json: { error: 'not admin' }, status: :unauthorized
      return
    end
    if @user.password_digest == login_params[:password]
      puts "password matched"
      time = Time.now + 72.hours.to_i
      @token = Token.encode(email: @user.email)
      render json: { token: @token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username, id: @user.id }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def test
    # this method is specifically added to test authorize_request
    render json: { message: "success" }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end