class Api::V1::SectionsController < Api::V1::ApplicationController
  before_action :authorize_request

  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    render json: { message: "success" }, status: :created
    @section.save
  end

  def destroy
    begin
      @section = Section.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      puts "section not found"
      render json: { error: 'wrong section id' }, status: :bad_request
      return
    end
    @section.destroy
  end

  def section_params
    params.require(:section).permit(:title,)
  end

end
