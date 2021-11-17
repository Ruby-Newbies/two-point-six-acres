class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authorize_request, except: [:index, :show, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @email = params[:email]
    if not (@email =~ /(.*)@(.*)\.edu$/i).nil?
      params[:email] = @email
      @user = User.new(user_params)
    else
      render json: { error: 'unauthorized email' }, status: :unauthorized
    end
  end

  def update
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      puts "user not found"
      render json: { errors: 'wrong user id' }, status: :bad_request
      return
    end
    #@user.email == @current_user.email
    @user.update(user_params)
  end

  def destroy
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      puts "user not found"
      render json: { error: 'wrong user id' }, status: :bad_request
      return
    end
    @user.destroy
  end

  private
  def user_params
    params.permit(
      :username, :email, :password, :password_confirmation, :role)
      .merge(role: 'usr')
  end

end
