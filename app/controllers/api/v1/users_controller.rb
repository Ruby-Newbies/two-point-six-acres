class Api::V1::UsersController < Api::V1::ApplicationController
  #before_action :require_login
  #skip_before_action :require_login, only: [:create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @email = params[:email]
    if @email =~ /(.*)@(.*)\.edu$/i
      params[:email] = @email
      @user = User.new(user_params)
    else
      render json: { error: 'unauthorized email' }, status: :unauthorized_email
    end
  end

  def update
    @user = User.find(params[:id])
    # this line for test only
    session[:currentuser] = @user.email
    if @user.nil?
      puts "user not found"
      render json: { error: 'user not exist' }, status: :wrong_user
      return
    elsif @user.email == session[:currentuser]
      @user.update(user_params)
    else
      render json: { error: 'unauthorized to update' }, status: :unauthorized_update
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.nil?
      puts "user not found"
      render json: { error: 'user not exist' }, status: :wrong_user
      return
    end
    if User.find_by_email(session[:currentuser]).role == 'admin'
      @user.destroy
    else
      render json: { error: 'unauthorized to delete' }, status: :unauthorized_delete
    end
  end

  private
  def user_params
    params.permit(
      :username, :email, :password, :password_confirmation, :role)
      .with_defaults(role: 'usr')
  end

end
