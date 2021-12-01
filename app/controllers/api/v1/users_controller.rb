class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authorize_request, except: [:index, :show, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create

    if not (params[:email] =~ /(.*)@(.*)\.edu$/i).nil?
      new_user_params = {
        :username => user_params[:username],
        :email => user_params[:email],
        :password_digest => user_params[:password],
        :role => user_params[:role]
      }
      @user = User.new(new_user_params)
      @user.save
    else
      render json: { error: 'invalid email' }, status: :bad_request
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
      .merge(role: 'user')
  end

end
