class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_default_request_format

  def index
    @users = User.all
  end
'''
  def show
    @user = User.find(params[:id])
  end
'''
  def create
    @user = User.new(user_params)
  end

  private

  def find_user
    @user = User.find_by_username(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'No user' }, status: :not_found
  end

  def user_params
    params.permit(
      :username, :email, :password, :password_confirmation
    )
  end

  def set_default_request_format
    request.format = :json unless params[:format]
  end
end
