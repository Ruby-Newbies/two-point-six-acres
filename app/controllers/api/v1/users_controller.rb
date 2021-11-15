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
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :wrong_user
      return
    end
    @current_user = User.authorize(request)
    if @current_user.nil?
      render json: { error: 'unauthorized to update' }, status: :unauthorized_update
      return
    elsif @user.email == @current_user.email
      @user.update(user_params)
    else
      render json: { error: 'unauthorized to update' }, status: :unauthorized_update
    end
  end

  def destroy
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :wrong_user
      return
    end
    @current_user = User.authorize(request)
    if @current_user.nil?
      render json: { error: 'unauthorized to delete' }, status: :unauthorized_delete
      return
    end
    if @current_user.role == 'admin'
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
