class Api::V1::SectionsController < Api::V1::ApplicationController
  #before_action :require_login

  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    @current_user = Section.authorize(request)
    if @current_user.nil?
      render json: { error: 'unauthorized create' }, status: :unauthorized_create
      return
    end
    if @current_user.role=="admin"
      @section.save
    else
      render json: { error: 'unauthorized create' }, status: :unauthorized_create
    end
  end

  def destroy
    begin
      @section = Section.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :unauthorized
      return
    end
    @current_user = Article.authorize(request)
    if @current_user.nil?
      render json: { error: 'unauthorized destroy' }, status: :unauthorized_destroy
      return
    end
    if @current_user.role=="admin"
      @section.destroy
    else
      render json: { error: 'unauthorized to delete' }, status: :unauthorized_delete
    end
  end

  def section_params
    params.require(:section).permit(:title,)
  end

end
