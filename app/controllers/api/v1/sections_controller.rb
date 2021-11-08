class Api::V1::SectionsController < Api::V1::ApplicationController
  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    @section.save
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.nil?
      puts "section not found"
      render json: { error: 'wrong section id' }, status: :wrongid
      return
    end
    @section.destroy
  end

  def section_params
    params.require(:section).permit(:title,)
  end

end
